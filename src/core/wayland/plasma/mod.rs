pub mod kde_decoration;
pub mod plasma;

use crate::core::state::CompositorState;
use wayland_server::DisplayHandle;

/// Register KDE/Plasma protocols
pub fn register(_state: &mut CompositorState, dh: &DisplayHandle) {
    use crate::core::wayland::plasma::kde_decoration::KdeDecorationManagerGlobal;
    use crate::core::wayland::plasma::plasma::{
        BlurManagerGlobal, ContrastManagerGlobal, ShadowManagerGlobal,
    };
    use crate::core::wayland::protocol::server::org_kde_kwin_server_decoration::org_kde_kwin_server_decoration_manager::OrgKdeKwinServerDecorationManager;
    use crate::core::wayland::protocol::server::plasma::{
        blur::server::org_kde_kwin_blur_manager::OrgKdeKwinBlurManager,
        contrast::server::org_kde_kwin_contrast_manager::OrgKdeKwinContrastManager,
        dpms::server::org_kde_kwin_dpms_manager::OrgKdeKwinDpmsManager,
        idle::server::org_kde_kwin_idle_timeout::OrgKdeKwinIdleTimeout,
        shadow::server::org_kde_kwin_shadow_manager::OrgKdeKwinShadowManager,
        slide::server::org_kde_kwin_slide_manager::OrgKdeKwinSlideManager,
    };

    dh.create_global::<
        CompositorState,
        OrgKdeKwinServerDecorationManager,
        KdeDecorationManagerGlobal,
    >(1, KdeDecorationManagerGlobal);
    crate::wlog!(
        crate::util::logging::COMPOSITOR,
        "Registered org_kde_kwin_server_decoration_manager (KDE fallback)"
    );

    dh.create_global::<CompositorState, OrgKdeKwinBlurManager, BlurManagerGlobal>(
        1,
        BlurManagerGlobal,
    );
    dh.create_global::<CompositorState, OrgKdeKwinContrastManager, ContrastManagerGlobal>(
        1,
        ContrastManagerGlobal,
    );
    dh.create_global::<CompositorState, OrgKdeKwinShadowManager, ShadowManagerGlobal>(
        1,
        ShadowManagerGlobal,
    );
    dh.create_global::<CompositorState, OrgKdeKwinDpmsManager, _>(1, ());
    dh.create_global::<CompositorState, OrgKdeKwinIdleTimeout, _>(1, ());
    dh.create_global::<CompositorState, OrgKdeKwinSlideManager, _>(1, ());

    crate::wlog!(
        crate::util::logging::COMPOSITOR,
        "Registered KDE/Plasma globals (blur, contrast, shadow, dpms, idle, slide)"
    );
}
