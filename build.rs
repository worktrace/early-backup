use std::{path::Path, slice::Iter};

use worktrace_build::logo::{render_svg_logo, RenderLogoErr};

fn main() {
    #[cfg(feature = "logo")]
    {
        let logo_names = ["worktrace-app", "worktrace-full"];
        render_logo("brand", "brand/out", logo_names.iter()).unwrap();
    }
}

fn render_logo(
    src_dir: impl AsRef<Path>,
    out_dir: impl AsRef<Path>,
    names: Iter<impl AsRef<str>>,
) -> Result<(), RenderLogoErr> {
    for name in names {
        let svg_src = src_dir.as_ref().join(format!("{}.svg", name.as_ref()));
        let png_out = out_dir.as_ref().join(format!("{}.png", name.as_ref()));
        render_svg_logo(&svg_src, &png_out)?;
    }
    Ok(())
}
