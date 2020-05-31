--# -path=.:../abstract

concrete MicroLangDummy of MicroLang = {

-- a very minimal concrete syntax: everything is just {s : Str}

-----------------------------------------------------
---------------- Grammar part -----------------------
-----------------------------------------------------

  lincat
-- Common
    Utt,    -- sentence, question, word...         e.g. "be quiet"

-- Cat
    S,      -- declarative sentence                e.g. "she lives here"
    VP,     -- verb phrase                         e.g. "lives here"
    Comp,   -- complement of copula                e.g. "warm"
    AP,     -- adjectival phrase                   e.g. "warm"
    CN,     -- common noun (without determiner)    e.g. "red house"
    NP,     -- noun phrase (subject or object)     e.g. "the red house"
    Det,    -- determiner phrase                   e.g. "those"
    Prep,   -- preposition, or just case           e.g. "in", dative
    V,      -- one-place verb                      e.g. "sleep" 
    V2,     -- two-place verb                      e.g. "love"
    A,      -- one-place adjective                 e.g. "warm"
    N,      -- common noun                         e.g. "house"
    Pron,   -- personal pronoun                    e.g. "she"
    Adv     -- adverbial phrase                    e.g. "in the house"
     = {s : Str} ;

  lin
-- Phrase
    -- : S  -> Utt ;         -- he walks
    UttS s = s ;

    -- : NP -> Utt ;         -- he
    UttNP np = np ;

-- Sentence
    -- : NP -> VP -> S ;             -- John walks
    PredVPS np vp = {s = np.s ++ vp.s} ;

-- Verb
    -- : V   -> VP ;             -- sleep
    UseV v = v ;

    -- : V2  -> NP -> VP ;       -- love it
    ComplV2 v2 np = {s = v2.s ++ np.s} ;

    -- : Comp  -> VP ;           -- be small
    UseComp comp = {s = "be" ++ comp.s} ;

    -- : AP  -> Comp ;           -- small
    CompAP ap = ap ;

    -- : VP -> Adv -> VP ;       -- sleep here
    AdvVP vp adv = {s = vp.s ++ adv.s} ;

-- Noun
    -- : Det -> CN -> NP ;       -- the man
    DetCN det cn = {
      s = det.s ++ cn.s ;
    } ;

    -- : Pron -> NP ;            -- she
    UsePron pron = pron ;

    -- : Det ;                   -- indefinite singular
    a_Det = {s = "a"} ;

    -- : Det ;                   -- indefinite plural
    aPl_Det = {s = ""} ;

    -- : Det ;                   -- definite singular   ---s
    the_Det = {s = "the"} ;

    -- : Det ;                   -- definite plural     ---s
    thePl_Det = {s = "the"} ;

    -- : N -> CN ;               -- house
    UseN n = n ;

    -- : AP -> CN -> CN ;        -- big house
    AdjCN ap cn = {
      s = ap.s ++ cn.s ;
    } ;

-- Adjective
    -- : A  -> AP ;              -- warm
    PositA a = a ;

-- Adverb
    -- : Prep -> NP -> Adv ;     -- in the house
    PrepNP prep np = {s = prep.s ++ np.s} ;

-- Structural
    -- : Prep ;
    in_Prep = mkPrep "in" ;
    on_Prep = mkPrep "on" ;
    with_Prep = mkPrep "with" ;

    he_Pron   = mkPron "he"   ;
    she_Pron  = mkPron "she"  ;
    they_Pron = mkPron "they" ;

oper

  mkPrep : Str -> {s : Str}  ;
  mkPrep str = {s = str} ;

  mkPron : Str -> {s : Str}  ;
  mkPron str = {s = str} ;

-----------------------------------------------------
---------------- Lexicon part -----------------------
-----------------------------------------------------

oper
  mkN : Str -> {s : Str} ;
  mkN str = {s = str} ;

  mkA : Str -> {s : Str} ;
  mkA str = {s = str} ;

  mkV : Str -> {s : Str} ;
  mkV str = {s = str} ;

  mkV2 : Str -> {s : Str} ;
  mkV2 str = {s = str} ;

  mkAdv : Str -> {s : Str} ;
  mkAdv str = {s = str} ;

lin
  already_Adv = mkAdv "already" ;
  animal_N = mkN "animal" ;
  apple_N = mkN "apple" ;
  baby_N = mkN "baby" ;
  bad_A = mkA "bad" ;
  beer_N = mkN "beer" ;
  big_A = mkA "big" ;
  bike_N = mkN "bike" ;
  bird_N = mkN "bird" ;
  black_A = mkA "black" ;
  blood_N = mkN "blood" ;
  blue_A = mkA "blue" ;
  boat_N = mkN "boat" ;
  book_N = mkN "book" ;
  boy_N = mkN "boy" ;
  bread_N = mkN "bread" ;
  break_V2 = mkV2 "break" ;
  buy_V2  = mkV2 "buy" ;
  car_N = mkN "car" ;
  cat_N = mkN "cat" ;
  child_N = mkN "child" ;
  city_N = mkN "city" ;
  clean_A = mkA "clean" ;
  clever_A = mkA "clever" ;
  cloud_N = mkN "cloud" ;
  cold_A = mkA "cold" ;
  come_V = mkV "come" ;
  computer_N = mkN "computer" ;
  cow_N = mkN "cow" ;
  dirty_A = mkA "dirty" ;
  dog_N = mkN "dog" ;
  drink_V2 = mkV2 "drink" ;
  eat_V2 = mkV2 "eat" ;
  find_V2 = mkV2 "find" ;
  fire_N = mkN "fire" ;
  fish_N = mkN "fish" ;
  flower_N = mkN "flower" ;
  friend_N = mkN "friend" ;
  girl_N = mkN "girl" ;
  good_A = mkA "good" ;
  go_V = mkV "go" ;
  grammar_N = mkN "grammar" ;
  green_A = mkA "green" ;
  heavy_A = mkA "heavy" ;
  horse_N = mkN "horse" ;
  hot_A = mkA "hot" ;
  house_N = mkN "house" ;
--  john_PN : PN ;
  jump_V = mkV "jump" ;
  kill_V2 = mkV2 "kill" ;
--  know_VS : VS ;
  language_N = mkN "language" ;
  live_V = mkV "live" ;
  love_V2  = mkV2 "love" ;
  man_N = mkN "man" ;
  milk_N = mkN "milk" ;
  music_N = mkN "music" ;
  new_A = mkA "new" ;
  now_Adv = mkAdv "now" ;
  old_A = mkA "old" ;
--  paris_PN : PN ;
  play_V = mkV "play" ;
  read_V2  = mkV2 "read" ;
  ready_A = mkA "ready" ;
  red_A = mkA "red" ;
  river_N = mkN "river" ;
  run_V = mkV "run" ;
  sea_N = mkN "sea" ;
  see_V2  = mkV2 "see" ;
  ship_N = mkN "ship" ;
  sleep_V = mkV "sleep" ;
  small_A = mkA "small" ;
  star_N = mkN "star" ;
  swim_V = mkV "swim" ;
  teach_V2 = mkV2 "teach" ;
  train_N = mkN "train" ;
  travel_V = mkV "travel" ;
  tree_N = mkN "tree" ;
  understand_V2 = mkV2 "understand" ;
  wait_V2 = mkV2 "wait" ;
  walk_V = mkV "walk" ;
  warm_A = mkA "warm" ;
  water_N = mkN "water" ;
  white_A = mkA "white" ;
  wine_N = mkN "wine" ;
  woman_N = mkN "woman" ;
  yellow_A = mkA "yellow" ;
  young_A = mkA "young" ;

}
