use std::{
    fs::read,
    path::{Path, PathBuf},
    slice::Iter,
};

use png::EncodingError;
use resvg::{render, tiny_skia::Pixmap};
use usvg::{Options, Transform, Tree};

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
}

pub fn svg_to_png(
    tree_map: &Tree,
    target: &RenderTarget,
) -> Result<(), RenderSvgErr> {
    let (width, height) = target.size.unwrap_or_else(|| {
        let size = tree_map.size().to_int_size();
        (size.width(), size.height())
    });
    let mut pixmap = Pixmap::new(width, height).ok_or(RenderSvgErr::Pixmap)?;

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

pub fn svg_to_pngs(
    source: impl AsRef<Path>,
    targets: Iter<RenderTarget>,
) -> Result<(), RenderSvgErr> {
    let data = read(source)?;
    let options = Options::default();
    let tree_map = Tree::from_data(&data, &options)?;
    for target in targets {
        svg_to_png(&tree_map, target)?;
    }
    Ok(())
}

#[derive(Debug, thiserror::Error)]
pub enum RenderSvgErr {
    #[error("file system error: {0}")]
    FS(#[from] std::io::Error),

    #[error("svg syntax error: {0}")]
    Syntax(#[from] usvg::Error),

    #[error("cannot create pixmap")]
    Pixmap,

    #[error("cannot encode png: {0}")]
    Encoding(#[from] EncodingError),
}
