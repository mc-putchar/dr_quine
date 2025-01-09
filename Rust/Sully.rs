//! Sully
//!
//! When executed the program writes in a file named Sully_X.rs. The X will be an integer given in the source. Once the file is created, the program compiles this file and then runs the new program (which will have the name of its source file).
//!
//! Stopping the program depends on the file name: the resulting program will be executed only if the integer X is greater or equals 0.

#![no_std]
#![no_main]

use core::panic::PanicInfo;
use core::arch::asm;

#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    unsafe { asm!("mov rax, 60", "mov rdi, 1", "syscall", options(noreturn)) }
}

/// Custom integer to ascii, will work for negative numbers as well
pub fn ft_itoa(mut num: i32, buffer: &mut [u8], index: &mut usize) {
    if num == 0 {
        buffer[*index] = '0' as u8;
        *index += 1;
    } else {
        let mut digits = [0u8; 11];
        let mut idx = 0;
        if num < 0 {
            digits[idx] = '-' as u8;
            idx += 1;
            num = -num;
        }
        while num > 0 {
            digits[idx] = (num % 10) as u8 + '0' as u8;
            idx += 1;
            num /= 10;
        }
        while idx > 0 {
            buffer[*index] = digits[idx - 1];
            *index += 1;
            idx -= 1;
        }
    }
}

macro_rules! clone {
    ($x: expr) => {
        let name = "Sully_";
        let ext = ".rs";
        let x: i32 = $x;
        let mut filename = [0u8; 22];
        let mut idx = 0;
        for byte in name.as_bytes() {
            filename[idx] = *byte;
            idx += 1;
        }
        ft_itoa(x, &mut filename, &mut idx);
        for byte in ext.as_bytes() {
            filename[idx] = *byte;
            idx += 1;
        }
        filename[idx] = 0u8;

        extern "C" {
            fn open(path: *const u8, flags: i32, mode: u32) -> i32;
            fn write(fd: i32, buf: *const u8, count: usize) -> isize;
            fn close(fd: i32) -> i32;
        }
        const O_WRONLY: i32 = 1;
        const O_CREAT: i32 = 64;
        const S_IRUSR: u32 = 256;
        const S_IWUSR: u32 = 128;
        let mut src = include_str!(file!());
        unsafe {
            let fd = open(filename.as_ptr(), O_WRONLY|O_CREAT, S_IRUSR|S_IWUSR);
            if fd >= 0 {
                write(fd, src.as_ptr(), src.len());
                close(fd);
            }
        }
    };
}

/// No main, no problem
#[no_mangle]
pub extern "C" fn _start() -> ! {
    let x: i32 = 5;
    clone!(x);
    unsafe { asm!("mov rax, 60", "mov rdi, 0", "syscall", options(noreturn)) }
}
