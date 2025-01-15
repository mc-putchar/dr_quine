//! Colleen
//!
//! Must contain:
//! * A main function.
//! * Two different comments.
//! * One of the comments must be present in the main function
//! * One of the comments must be present outside of your program.
//! * Another function in addition to the main function (which of course will be called)

/// Quine - embeds its own source code as a string in the program
fn quine() -> String {
    let source = include_str!(file!());
    source.to_string()
}

fn main() {
    /*
        Elizabeth Quinn: And what are you?
        You're an unmarried woman,
        trying to raise three children,
        in a shack, in the middle of nowhere...
        and offering your medical services
        to a bunch of back-woodsman,
        who pay you in potatoes and in chickens.
    */
    print!("{}", quine());
}
