use std::{fs::read, path::Path};

use png::EncodingError;
use resvg::{render, tiny_skia::Pixmap};
use usvg::{Options, Transform, Tree};

pub fn render_svg_logo(
    svg_src_path: impl AsRef<Path>,
    png_out_path: impl AsRef<Path>,
    size: Option<(u32, u32)>,
) -> Result<(), RenderLogoErr> {
    let svg_data = read(svg_src_path)?;
    let options = Options::default();
    let tree_map = Tree::from_data(&svg_data, &options)?;

    // Pixel map size, when not specified, use svg size by default.
    let (width, height) = size.unwrap_or_else(|| {
        let size = tree_map.size().to_int_size();
        (size.width(), size.height())
    });
    let mut pixmap = Pixmap::new(width, height).ok_or(RenderLogoErr::Pixmap)?;

    // Transform as configured size, scale rather than clip.
    let transform = if let Some(size) = size {
        let (width, height) = size;
        let svg_size = tree_map.size().to_int_size();
        let scale_x = width as f32 / svg_size.width() as f32;
        let scale_y = height as f32 / svg_size.height() as f32;
        Transform::from_scale(scale_x, scale_y)
    } else {
        Transform::default()
    };

    render(&tree_map, transform, &mut pixmap.as_mut());
    pixmap.save_png(png_out_path)?;
    Ok(())
}

#[derive(Debug, thiserror::Error)]
pub enum RenderLogoErr {
    #[error("file system error: {0}")]
    FS(#[from] std::io::Error),

    #[error("svg syntax error: {0}")]
    Syntax(#[from] usvg::Error),

    #[error("cannot create pixmap")]
    Pixmap,

    #[error("cannot encode png: {0}")]
    Encoding(#[from] EncodingError),
}
