use std::{path::Path, slice::Iter};

use worktrace_build::logo::{render_svg_logo, RenderLogoErr};

fn main() {
    #[cfg(feature = "logo")]
    {
        let logo_names = ["worktrace-app", "worktrace-full"];
        render_logo("brand", logo_names.iter()).unwrap();
    }
}

fn render_logo(
    base_path: impl AsRef<Path>,
    names: Iter<impl AsRef<str>>,
) -> Result<(), RenderLogoErr> {
    for name in names {
        let svg_src = base_path.as_ref().join(format!("{}.svg", name.as_ref()));
        let png_out = base_path.as_ref().join(format!("{}.png", name.as_ref()));
        render_svg_logo(&svg_src, &png_out)?;
    }
    Ok(())
}
