#[no_mangle]
pub extern "C" fn run_rust_task_ffi() {
    std::thread::spawn(|| {
        let rt = tokio::runtime::Runtime::new().unwrap();
        rt.block_on(run_rust_task());
    });
}

async fn run_rust_task() {
    loop {
        println!("Hello from Rust!");
        tokio::time::sleep(std::time::Duration::from_secs(1)).await;
    }
}

#[cfg(test)]
mod tests {}
