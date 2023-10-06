use notify_rust::Notification;

#[no_mangle]
pub extern "C" fn show_notification_ffi(title: *const libc::c_char, body: *const libc::c_char) {
    let title = unsafe { std::ffi::CStr::from_ptr(title).to_str().unwrap() }.to_string();
    let body = unsafe { std::ffi::CStr::from_ptr(body).to_str().unwrap() }.to_string();
    show_notification(title, body);
}

fn show_notification(title: String, body: String) {
    if let Err(err) = Notification::new().summary(&title).body(&body).show() {
        eprintln!("error showing notification: {}", err);
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_show_notification() {
        show_notification("title".to_string(), "body".to_string());
    }
}
