use std::{
    fs::{read, remove_file, File},
    io::BufWriter,
    path::{Path, PathBuf},
    slice::Iter,
};

use image::{codecs::ico::IcoEncoder, ImageError, ImageReader};
use png::EncodingError;
use resvg::{render, tiny_skia::Pixmap};
use usvg::{Options, Transform, Tree};

pub struct FlutterLogoSources {
    /// Path to the svg logo with smooth corner radius and paddings,
    /// which is usually designed for Windows, macOS, Linux and HarmonyOS.
    pub app: PathBuf,

    /// Path to the full sized square svg logo,
    /// which is usually designed for Android and iOS.
    pub full: PathBuf,

    /// Path to the circle svg logo,
    /// which is usually designed for web browser favicon.
    pub round: PathBuf,
}

impl FlutterLogoSources {
    pub fn from(app: impl AsRef<Path>, full: impl AsRef<Path>, round: impl AsRef<Path>) -> Self {
        Self {
            app: app.as_ref().into(),
            full: full.as_ref().into(),
            round: round.as_ref().into(),
        }
    }

    /// Render png files into all image files required by a Flutter app.
    pub fn apply(&self, flutter_app_root: impl AsRef<Path>) -> Result<(), RenderImageErr> {
        let flutter_app_root = flutter_app_root.as_ref();
        self.apply_android(flutter_app_root)?;
        self.apply_ios(flutter_app_root)?;
        self.apply_macos(flutter_app_root)?;
        self.apply_web(flutter_app_root)?;
        self.apply_windows(flutter_app_root)?;
        Ok(())
    }

    pub fn apply_android(&self, flutter_app_root: &Path) -> Result<(), RenderImageErr> {
        let base_path = flutter_app_root
            .join("android")
            .join("app")
            .join("src")
            .join("main")
            .join("res");

        let format_path = |name: &str| {
            base_path
                .join(format!("mipmap-{}", name))
                .join("ic_launcher.png")
        };
        let hdpi = RenderTarget::square(format_path("hdpi"), 72);
        let mdpi = RenderTarget::square(format_path("mdpi"), 48);
        let xhdpi = RenderTarget::square(format_path("xhdpi"), 96);
        let xxhdpi = RenderTarget::square(format_path("xxhdpi"), 144);
        let xxxhdpi = RenderTarget::square(format_path("xxxhdpi"), 192);
        svg_to_pngs(&self.full, [hdpi, mdpi, xhdpi, xxhdpi, xxxhdpi].iter())
    }

    pub fn apply_ios(&self, flutter_app_root: &Path) -> Result<(), RenderImageErr> {
        let base_path = flutter_app_root
            .join("ios")
            .join("Runner")
            .join("Assets.xcassets")
            .join("AppIcon.appiconset");

        let target_from = |base_size: u32, times: u32| {
            let filename = format!("Icon-App-{}x{}@{}x.png", base_size, base_size, times);
            RenderTarget::square(base_path.join(filename), base_size * times)
        };
        let targets: [RenderTarget; 15] = [
            target_from(20, 1),
            target_from(20, 2),
            target_from(20, 3),
            target_from(29, 1),
            target_from(29, 2),
            target_from(29, 3),
            target_from(40, 1),
            target_from(40, 2),
            target_from(40, 3),
            target_from(60, 2),
            target_from(60, 3),
            target_from(76, 1),
            target_from(76, 2),
            RenderTarget::square(base_path.join("Icon-App-83.5x83.5@2x.png"), 167),
            target_from(1024, 1),
        ];
        svg_to_pngs(&self.full, targets.iter())
    }

    pub fn apply_macos(&self, flutter_app_root: &Path) -> Result<(), RenderImageErr> {
        let base_path = flutter_app_root
            .join("macos")
            .join("Runner")
            .join("Assets.xcassets")
            .join("AppIcon.appiconset");
        let target_from = |size: u32| {
            let filename = format!("app_icon_{}.png", size);
            RenderTarget::square(base_path.join(filename), size)
        };
        let targets: [RenderTarget; 7] = [
            target_from(16),
            target_from(32),
            target_from(64),
            target_from(128),
            target_from(256),
            target_from(512),
            target_from(1024),
        ];
        svg_to_pngs(&self.app, targets.iter())
    }

    pub fn apply_web(&self, flutter_app_root: &Path) -> Result<(), RenderImageErr> {
        let base_path = flutter_app_root.join("web").join("icons");
        let target_from = |size: u32| {
            let filename = format!("Icon-{}.png", size);
            RenderTarget::square(base_path.join(filename), size)
        };
        let maskable_target_from = |size: u32| {
            let filename = format!("Icon-maskable-{}.png", size);
            RenderTarget::square(base_path.join(filename), size)
        };
        let targets: [RenderTarget; 4] = [
            target_from(192),
            target_from(512),
            maskable_target_from(192),
            maskable_target_from(512),
        ];
        svg_to_pngs(&self.full, targets.iter())
    }

    pub fn apply_windows(&self, flutter_app_root: &Path) -> Result<(), RenderImageErr> {
        let base_path = flutter_app_root
            .join("windows")
            .join("runner")
            .join("resources");
        const FILENAME: &str = "app_icon";
        let png_path = base_path.join(format!("{}.png", FILENAME));
        let ico_path = base_path.join(format!("{}.ico", FILENAME));
        svg_to_png(&self.app, RenderTarget::square(&png_path, 1024))?;
        png_to_ico(&png_path, ico_path)?;
        remove_file(png_path)?;
        Ok(())
    }
}

pub struct RenderTarget {
    pub path: PathBuf,
    pub size: Option<(u32, u32)>,
}

impl RenderTarget {
    pub fn from(path: impl AsRef<Path>, size: Option<(u32, u32)>) -> Self {
        Self {
            path: path.as_ref().into(),
            size,
        }
    }

    pub fn square(path: impl AsRef<Path>, size: u32) -> Self {
        Self::from(path, Some((size, size)))
    }
}

/// Render a single png file from the tree map.
pub fn svg_tree_to_png(tree_map: &Tree, target: &RenderTarget) -> Result<(), RenderImageErr> {
    let (width, height) = target.size.unwrap_or_else(|| {
        let size = tree_map.size().to_int_size();
        (size.width(), size.height())
    });
    let mut pixmap = Pixmap::new(width, height).ok_or(RenderImageErr::Pixmap)?;

    // Transform as configured size, scale rather than clip.
    let transform = if let Some(size) = target.size {
        let (width, height) = size;
        let svg_size = tree_map.size().to_int_size();
        let scale_x = width as f32 / svg_size.width() as f32;
        let scale_y = height as f32 / svg_size.height() as f32;
        Transform::from_scale(scale_x, scale_y)
    } else {
        Transform::default()
    };

    render(&tree_map, transform, &mut pixmap.as_mut());
    pixmap.save_png(&target.path)?;
    Ok(())
}

pub fn svg_to_png(src: impl AsRef<Path>, target: RenderTarget) -> Result<(), RenderImageErr> {
    let data = read(src)?;
    let options = Options::default();
    let tree = Tree::from_data(&data, &options)?;
    svg_tree_to_png(&tree, &target)
}

/// Render from a single svg source to multiple png file targets.
pub fn svg_to_pngs(
    src: impl AsRef<Path>,
    targets: Iter<RenderTarget>,
) -> Result<(), RenderImageErr> {
    let data = read(src)?;
    let options = Options::default();
    let tree = Tree::from_data(&data, &options)?;
    for target in targets {
        svg_tree_to_png(&tree, target)?;
    }
    Ok(())
}

pub fn png_to_ico(src: impl AsRef<Path>, out: impl AsRef<Path>) -> Result<(), RenderImageErr> {
    let encoder = IcoEncoder::new(BufWriter::new(File::create(out)?));
    ImageReader::open(src)?
        .with_guessed_format()?
        .decode()?
        .write_with_encoder(encoder)?;
    Ok(())
}

#[derive(Debug, thiserror::Error)]
pub enum RenderImageErr {
    #[error("file system error: {0}")]
    FS(#[from] std::io::Error),

    #[error("svg syntax error: {0}")]
    Syntax(#[from] usvg::Error),

    #[error("cannot create pixmap")]
    Pixmap,

    #[error("image format error")]
    Format(#[from] ImageError),

    #[error("cannot encode png: {0}")]
    Encoding(#[from] EncodingError),
}
