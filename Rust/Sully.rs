//! Sully
//!
//! When executed the program writes its source code in a file named Sully_X.rs. The X will be an integer given in the source. Once the file is created, the program compiles this file and then runs the new program (which will have the name of its source file).
//!
//! Stopping the program depends on the file name: the resulting program will be executed only if the integer X is greater or equals 0.

#![no_std]
#![no_main]

use core::ptr;
use core::panic::PanicInfo;

#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {}
}

extern "C" {
    fn open(path: *const u8, flags: i32, mode: u32) -> i32;
    fn write(fd: i32, buf: *const u8, count: usize) -> isize;
    fn close(fd: i32) -> i32;
    fn vfork() -> i32;
    fn execvp(file: *const u8, argv: *const *const u8) -> i32;
    fn waitpid(pid: i32, status: *mut i32, options: i32) -> i32;
    fn _exit(status: i32) -> !;
}

/// 42 style integer to ascii
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

/// Copy bytes in memory
pub fn ft_memcpy(dest: &mut [u8], src: &[u8], start: usize, len: usize) {
    unsafe {
        let dest_ptr = dest.as_mut_ptr().add(start);
        let src_ptr = src.as_ptr();
        for i in 0..len {
            *dest_ptr.add(i) = *src_ptr.add(i);
        }
    }
}

/// Find needle in memory haystack
pub fn findmem(src: &[u8], target: &[u8]) -> Option<usize> {
    if target.len() > src.len() {
        return None;
    }
    for i in 0..=(src.len() - target.len()) {
        if &src[i..i + target.len()] == target && (i == 0 || src[i - 1] != b'"') {
            return Some(i);
        }
    }
    None
}

/// Get the new line
#[allow(dead_code)]
fn gnl(src: &[u8], start: usize) -> Option<usize> {
    for i in start..src.len() {
        if src[i] == b'\n' {
            return Some(i);
        }
    }
    None
}

/// Modify the embedded source code to reflect the change of i variable
#[allow(dead_code)]
fn mod_i(src: &mut [u8], i: i32) {
    let line = b"let i: i32 = ";
    let mut new_decl = [0u8; 26];
    let mut idx = 0;
    for &byte in line {
        new_decl[idx] = byte;
        idx += 1;
    }
    ft_itoa(i, &mut new_decl, &mut idx);
    if let Some(start) = findmem(src, line) {
        if let Some(end) = gnl(src, start) {
            if idx + 1 < end - start {
                new_decl[idx] = b' ';
                idx += 1;
            }
            new_decl[idx] = b';';
            ft_memcpy(&mut src[start..end], &new_decl[..idx + 1], 0, idx + 1);
        }
    }
}

macro_rules! clone {
    ($f: expr, $x: expr) => {
        const O_WRONLY: i32 = 1;
        const O_CREAT: i32 = 64;
        const S_IRUSR: u32 = 256;
        const S_IWUSR: u32 = 128;
        let filename = $f;
        let _i: i32 = $x;
        let src = include_str!(file!());
        let src_len = src.len();
        let fd;
        unsafe {
            fd = open(filename.as_ptr(), O_WRONLY|O_CREAT, S_IRUSR|S_IWUSR);
            if fd >= 0 {
                #[cfg(init)]
                { write(fd, src.as_ptr(), src_len); }
                #[cfg(not(init))]
                {
                    let mut _mod_src = [0u8; 8192];
                    ft_memcpy(&mut _mod_src, &src[..src_len].as_bytes(), 0, src_len);
                    mod_i(&mut _mod_src, _i);
                    let mut _nil = 0;
                    while _nil < _mod_src.len() && _mod_src[_nil] != 0 {
                        _nil += 1;
                    }
                    write(fd, _mod_src.as_ptr(), _nil);
                }
                close(fd);
            }
        }
    }
}

macro_rules! compile {
    ($x: expr) => {
        let filename = $x;
        let mut output = [0u8; 20];
        let mut _nil = 0;
        while _nil < filename.len() && filename[_nil] != 0 {
            _nil += 1;
        }
        ft_memcpy(&mut output, &filename, 0, _nil - 3);
        let args = [
            b"rustc\0".as_ptr(), b"-O\0".as_ptr(),
            b"-C\0".as_ptr(), b"panic=abort\0".as_ptr(),
            b"--crate-type\0".as_ptr(), b"bin\0".as_ptr(),
            b"-C\0".as_ptr(), b"relocation-model=static\0".as_ptr(),
            filename.as_ptr(), b"-o\0".as_ptr(), output.as_ptr(),
            b"-C\0".as_ptr(), b"link-args=-nostartfiles -lc\0".as_ptr(),
            ptr::null(),
        ];
        unsafe {
            let pid = vfork();
            if pid < 0 { _exit(42); }
            else if pid == 0 { execvp(args[0], args.as_ptr()); _exit(42); }
            else {
                let mut status = 0;
                if waitpid(pid, &mut status, 0) < 0 || status != 0 {
                    _exit(42);
                }
                let mut cmd = [0u8; 22];
                cmd[0] = b'.';
                cmd[1] = b'/';
                ft_memcpy(&mut cmd, &output, 2, _nil - 3);
                let exargs = [ cmd.as_ptr(), ptr::null() ];
                execvp(exargs[0], exargs.as_ptr());
            }
        }
    }
}

/// No main, no problem
#[no_mangle]
pub extern "C" fn _start() -> ! {
    let i: i32 = 42;
    if i < 0 { unsafe { _exit(0); } }
    let mut _x = i;
    #[cfg(not(init))]
    { _x -= 1; }
    let name = "Sully_";
    let ext = ".rs";
    let mut filename = [0u8; 22];
    let mut idx = 0;
    for byte in name.as_bytes() {
        filename[idx] = *byte;
        idx += 1;
    }
    ft_itoa(_x, &mut filename, &mut idx);
    for byte in ext.as_bytes() {
        filename[idx] = *byte;
        idx += 1;
    }
    filename[idx] = 0u8;
    clone!(filename, _x);
    if _x == 0 { unsafe { _exit(0); } }
    compile!(filename);
    unsafe { _exit(42); }
}
