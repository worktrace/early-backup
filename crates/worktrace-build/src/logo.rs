use std::{fs::read, path::Path};

use png::EncodingError;
use resvg::{render, tiny_skia::Pixmap};
use usvg::{Options, Transform, Tree};

pub fn render_svg_logo(
    svg_src_path: impl AsRef<Path>,
    png_out_path: impl AsRef<Path>,
) -> Result<(), RenderLogoErr> {
    let svg_data = read(svg_src_path)?;
    let options = Options::default();
    let tree_map = Tree::from_data(&svg_data, &options)?;
    let pixmap_size = tree_map.size().to_int_size();
    let mut pixmap = Pixmap::new(pixmap_size.width(), pixmap_size.height())
        .ok_or(RenderLogoErr::Pixmap)?;

    render(&tree_map, Transform::default(), &mut pixmap.as_mut());
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
