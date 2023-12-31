use std::fmt;

struct Lcrng {
    state: u32,
}

impl Lcrng {
    fn new(seed: u32) -> Self {
        Self { state: seed }
    }

    fn step(&mut self) -> u32 {
        self.state = self.state.wrapping_mul(0x41c64e6d).wrapping_add(0x6073);
        self.state
    }

    fn next_u16(&mut self) -> u32 {
        self.step() >> 16
    }

    fn next_u32(&mut self) -> u32 {
        self.next_u16() << 16 | self.next_u16()
    }
}

#[derive(PartialEq)]
struct IVs {
    hp: u8,
    atk: u8,
    def: u8,
    spa: u8,
    spd: u8,
    spe: u8,
}

impl IVs {
    fn new(iv32: u32) -> Self {
        Self {
            hp: (iv32 & 0x1F) as u8,
            atk: ((iv32 >> 5) & 0x1F) as u8,
            def: ((iv32 >> 10) & 0x1F) as u8,
            spe: ((iv32 >> 15) & 0x1F) as u8,
            spa: ((iv32 >> 20) & 0x1F) as u8,
            spd: ((iv32 >> 25) & 0x1F) as u8,
        }
    }
}

impl fmt::Display for IVs {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(
            f,
            "{:02}/{:02}/{:02}/{:02}/{:02}/{:02}",
            self.hp, self.atk, self.def, self.spa, self.spd, self.spe
        )
    }
}

fn check_if_shiny(tid: u32, sid: u32, pid: u32) -> bool {
    (tid ^ sid ^ (pid & 0xffff) ^ (pid >> 16)) < 8
}

const WISHMAKER_TID: u32 = 20043;
const METEOR_TID: u32 = 30719;

pub struct Jirachi {
    pid: u32,
    ivs: IVs,
    is_shiny: bool,
}

impl Jirachi {
    fn new(seed: u32, tid: u32) -> Self {
        let mut rng = Lcrng::new(seed);
        let pid = rng.next_u32();
        let iv1 = rng.next_u16();
        let iv2 = rng.next_u16();
        let ivs = IVs::new(iv2 << 15 | iv1);
        let is_shiny = check_if_shiny(tid, 0, pid);

        Self { pid, ivs, is_shiny }
    }

    pub fn new_wishmaker(seed: impl Into<u32>) -> Self {
        Self::new(seed.into(), WISHMAKER_TID)
    }

    pub fn new_meteor(seed: impl Into<u32>) -> Self {
        Self::new(seed.into(), METEOR_TID)
    }

    pub fn new_wishing_star(seed: impl Into<u32>) -> Self {
        let tid = METEOR_TID;
        let mut rng = Lcrng::new(seed.into());

        // Skip 2
        rng.next_u16();
        rng.next_u16();

        let mut pid = rng.next_u32();
        let iv1 = rng.next_u16();
        let iv2 = rng.next_u16();
        let ivs = IVs::new(iv2 << 15 | iv1);
        let mut is_shiny = check_if_shiny(tid, 0, pid);

        while is_shiny {
            pid = pid.wrapping_add(1);
            is_shiny = check_if_shiny(tid, 0, pid);
        }

        Self { pid, ivs, is_shiny }
    }
}

impl fmt::Display for Jirachi {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(
            f,
            "PID: {:08x}, IVs: {}, Shiny: {}",
            self.pid, self.ivs, self.is_shiny
        )
    }
}
