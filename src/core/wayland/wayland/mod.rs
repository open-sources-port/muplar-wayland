pub mod compositor;
pub mod display;
pub mod output;
pub mod registry;
pub mod seat;

use crate::core::state::CompositorState;
use wayland_server::DisplayHandle;

/// Register core Wayland protocols
/// Phase D: Creates one wl_output global per output in state for multi-output support.
pub fn register(state: &mut CompositorState, dh: &DisplayHandle) {
    use crate::core::wayland::wayland::output::OutputGlobal;
    use crate::core::wayland::wayland::seat::SeatGlobal;
    use wayland_server::protocol::{
        wl_compositor, wl_data_device_manager, wl_output, wl_seat, wl_shm, wl_subcompositor,
    };

    dh.create_global::<CompositorState, wl_compositor::WlCompositor, _>(6, ());
    crate::wlog!(
        crate::util::logging::COMPOSITOR,
        "Registered wl_compositor v6"
    );

    dh.create_global::<CompositorState, wl_shm::WlShm, _>(1, ());
    crate::wlog!(crate::util::logging::COMPOSITOR, "Registered wl_shm v1");

    for output in &state.outputs {
        dh.create_global::<CompositorState, wl_output::WlOutput, OutputGlobal>(
            3,
            OutputGlobal::new(output.id),
        );
    }
    crate::wlog!(
        crate::util::logging::COMPOSITOR,
        "Registered {} wl_output(s) v3",
        state.outputs.len()
    );

    dh.create_global::<CompositorState, wl_seat::WlSeat, SeatGlobal>(8, SeatGlobal::default());
    crate::wlog!(crate::util::logging::COMPOSITOR, "Registered wl_seat v8");

    dh.create_global::<CompositorState, wl_subcompositor::WlSubcompositor, _>(1, ());
    crate::wlog!(
        crate::util::logging::COMPOSITOR,
        "Registered wl_subcompositor v1"
    );

    dh.create_global::<CompositorState, wl_data_device_manager::WlDataDeviceManager, _>(3, ());
    crate::wlog!(
        crate::util::logging::COMPOSITOR,
        "Registered wl_data_device_manager v3"
    );
}
