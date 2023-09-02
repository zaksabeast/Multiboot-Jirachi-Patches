use chrono::{Datelike, Duration, NaiveDate, NaiveDateTime, Timelike};

fn gba_epoch() -> NaiveDateTime {
    NaiveDate::from_ymd_opt(2000, 1, 1)
        .unwrap()
        .and_hms_opt(0, 0, 0)
        .unwrap()
}

fn seed_from_date(date: NaiveDateTime) -> u16 {
    let days_since_epoch = date.signed_duration_since(gba_epoch()).num_days() as u32;
    // Thanks to PokeFinder - https://github.com/Admiral-Fish/PokeFinder/blob/a8792b45206e0f96567ab6375c9cb2c21dd11e09/Source/Core/Gen3/Tools/SeedToTimeCalculator3.cpp#L46-L48
    let ordinal = days_since_epoch - if date.year() > 2000 { 366 } else { 0 } + 1;
    let seed_u32: u32 = 1440 * ordinal
        + 960 * (date.hour() / 10)
        + 60 * (date.hour() % 10)
        + 16 * (date.minute() / 10)
        + (date.minute() % 10);
    (seed_u32 >> 16) as u16 ^ (seed_u32 as u16)
}

const MINUTES_OF_4_YEARS: usize = 60 * 24 * 366 * 4;

pub fn calc_rtc(seed: u16) -> Option<NaiveDateTime> {
    let mut date = gba_epoch();
    let one_minute = Duration::minutes(1);

    for _minutes in 0..=MINUTES_OF_4_YEARS {
        if seed == seed_from_date(date) {
            return Some(date);
        }

        date += one_minute;
    }

    None
}
