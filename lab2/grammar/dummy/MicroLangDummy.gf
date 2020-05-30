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
    Adv    -- adverbial phrase                    e.g. "in the house"
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
  -- apple_N : N ;
  -- baby_N : N ;
  bad_A = mkA "bad" ;
{-  beer_N : N ;
  big_A : A ;
  bike_N : N ;
  bird_N : N ;
  black_A : A ;
  blood_N : N ;
  blue_A : A ;
  boat_N : N ;
  book_N : N ;
  boy_N : N ;
  bread_N : N ; -}
  break_V2 = mkV2 "break" ;
{-  buy_V2 : V2 ;
  car_N : N ;
  cat_N : N ;
  child_N : N ;
  city_N : N ;
  clean_A : A ;
  clever_A : A ;
  cloud_N : N ;
  cold_A : A ;
  come_V : V ;
  computer_N : N ;
  cow_N : N ;
  dirty_A : A ;
  dog_N : N ;
  drink_V2 : V2 ;
  eat_V2 : V2 ;
  find_V2 : V2 ;
  fire_N : N ;
  fish_N : N ;
  flower_N : N ;
  friend_N : N ;
  girl_N : N ;
  good_A : A ;
  go_V : V ;
  grammar_N : N ;
  green_A : A ;
  heavy_A : A ;
  horse_N : N ;
  hot_A : A ;
  house_N : N ;
--  john_PN : PN ;
  jump_V : V ;
  kill_V2 : V2 ;
--  know_VS : VS ;
  language_N : N ;
  live_V : V ;
  love_V2 : V2 ;
  man_N : N ;
  milk_N : N ;
  music_N : N ;
  new_A : A ;
  now_Adv : Adv ;
  old_A : A ;
--  paris_PN : PN ;
  play_V : V ;
  read_V2 : V2 ;
  ready_A : A ;
  red_A : A ;
  river_N : N ;
  run_V : V ;
  sea_N : N ;
  see_V2 : V2 ;
  ship_N : N ;
  sleep_V : V ;
  small_A : A ;
  star_N : N ;
  swim_V : V ;
  teach_V2 : V2 ;
  train_N : N ;
  travel_V : V ;
  tree_N : N ;
  understand_V2 : V2 ;
  wait_V2 : V2 ;
  walk_V : V ;
  warm_A : A ;
  water_N : N ;
  white_A : A ;
  wine_N : N ;
  woman_N : N ;
  yellow_A : A ;
  young_A : A ;-}

}
