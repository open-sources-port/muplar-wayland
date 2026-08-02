//! Wayland Protocol Implementation
//!
//! This module organizes the various Wayland protocol implementations into
//! logical categories for better maintainability.

pub mod ext;
pub mod plasma;
pub mod protocol;
pub mod wayland;
pub mod wlr;
pub mod xdg;

// Re-exports for common types if needed
pub use crate::core::state::CompositorState as CompositorData;
pub use crate::core::state::OutputState as OutputData;
pub use wayland::display::WawonaDisplay as WaylandDisplay;
// SeatData is in state.rs too
pub use crate::core::state::SeatState as SeatData;

pub mod presentation_time {
    pub use crate::core::wayland::ext::presentation_time::*;
}
