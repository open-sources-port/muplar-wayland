//! Platform Integration Module
//!
//! Wawona uses a **Rust backend + Native frontend** architecture.
//! The macOS frontend calls into Rust via FFI.

pub mod api;

pub use api::Platform;
