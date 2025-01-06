use std::{env::var, path::PathBuf};

use worktrace_build::logo::{FlutterLogoSources, RenderSvgErr};

fn main() {
    let root = PathBuf::from(var("CARGO_MANIFEST_DIR").unwrap());
    #[cfg(feature = "logo")]
    {
        apply_logo(&root).unwrap();
    }
}

fn apply_logo(root: &PathBuf) -> Result<(), RenderSvgErr> {
    let brand = root.join("brand");
    let flutter_logos = FlutterLogoSources::from(
        brand.join("worktrace-app.svg"),
        brand.join("worktrace-full.svg"),
        brand.join("worktrace-round.svg"),
    );
    flutter_logos.apply(root.join("apps").join("flutter"))
}
