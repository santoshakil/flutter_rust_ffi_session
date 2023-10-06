use libc::{c_char, c_int};

#[no_mangle]
pub extern "C" fn add_two_numbers(a: *const c_char, b: *const c_char) -> c_int {
    let a = unsafe { std::ffi::CStr::from_ptr(a).to_str().unwrap() }.to_string();
    let b = unsafe { std::ffi::CStr::from_ptr(b).to_str().unwrap() }.to_string();
    let a_int = a.parse::<i32>().unwrap();
    let b_int = b.parse::<i32>().unwrap();
    let c = a_int + b_int;
    println!("SUM: {}", c);
    c as c_int
}
