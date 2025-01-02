use std::{fs::read, path::Path};

use png::EncodingError;
use resvg::{render, tiny_skia::Pixmap};
use usvg::{Options, Transform, Tree};

pub fn apply_flutter_logo(
    svg_path: impl AsRef<Path>,
    flutter_app_root: impl AsRef<Path>,
) -> Result<(), ApplyLogoError> {
    let svg_data = read(svg_path)?;
    let options = Options::default();
    let tree_map = Tree::from_data(&svg_data, &options)?;
    let pixmap_size = tree_map.size().to_int_size();
    let mut pixmap = Pixmap::new(pixmap_size.width(), pixmap_size.height())
        .ok_or(ApplyLogoError::Pixmap)?;

    render(&tree_map, Transform::default(), &mut pixmap.as_mut());
    pixmap.save_png(flutter_app_root.as_ref().join("logo.png"))?;
    Ok(())
}

#[derive(Debug, thiserror::Error)]
pub enum ApplyLogoError {
    #[error("file system error: {0}")]
    FS(#[from] std::io::Error),

    #[error("svg syntax error: {0}")]
    Syntax(#[from] usvg::Error),

    #[error("cannot create pixmap")]
    Pixmap,

    #[error("cannot encode png: {0}")]
    Encoding(#[from] EncodingError),
}
