mod jirachi;
mod rtc;

use jirachi::Jirachi;
use rtc::calc_rtc;

use clap::Parser;
use clap_num::maybe_hex;

/// Reference implementation for multiboot jirachi RNGs
#[derive(Parser, Debug)]
#[command(author, version, about, long_about = None)]
struct Args {
    /// The RNG seed
    #[clap(short, long, value_parser=maybe_hex::<u16>)]
    seed: u16,
}

fn main() {
    let Args { seed } = Args::parse();
    println!("Wishmaker: {}", Jirachi::new_wishmaker(seed));
    println!("Meteor: {}", Jirachi::new_meteor(seed));
    println!(
        "Wishing Star: {}, RTC {}",
        Jirachi::new_wishing_star(seed),
        calc_rtc(seed).unwrap().format("%m/%d/%Y %H:%M").to_string()
    );
}
