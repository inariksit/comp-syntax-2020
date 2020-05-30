--# -path=.:../abstract

concrete MicroLangDummyWithGender of MicroLang = {

-- a very minimal concrete syntax: everything is just {s : Str}
-- except that nouns have gender

-----------------------------------------------------
---------------- Grammar part -----------------------
-----------------------------------------------------

  lincat

-- Common
    Utt,    -- sentence, question, word...         e.g. "be quiet"

-- Cat
    S,      -- declarative sentence                e.g. "she lives here"

    Det,    -- determiner phrase                   e.g. "those"
    Prep,   -- preposition, or just case           e.g. "in", dative
    Adv    -- adverbial phrase                    e.g. "in the house"
     = {s : Str} ;

    Pron,   -- personal pronoun                    e.g. "she"
    N,      -- common noun                         e.g. "house"
    CN,     -- common noun (without determiner)    e.g. "red house"
    NP     -- noun phrase (subject or object)     e.g. "the red house"
     = {s : Str ; g : NounClass} ;

    V,      -- one-place verb                      e.g. "sleep"
    V2,     -- two-place verb                      e.g. "love"
    VP,     -- verb phrase                         e.g. "lives here"
    Comp,   -- complement of copula                e.g. "warm"
    AP,     -- adjectival phrase                   e.g. "warm"
    A       -- one-place adjective                 e.g. "warm"
     = {s : NounClass => Str} ;

  param
    NounClass = Class1 | Class2 ;

  lin
-- Phrase
    -- : S  -> Utt ;         -- he walks
    UttS s = s ;

    -- : NP -> Utt ;         -- he
    UttNP np = np ;

-- Sentence
    -- : NP -> VP -> S ;             -- John walks
    PredVPS np vp = {
      s = np.s ++ vp.s ! np.g 
    } ;

-- Verb
    -- : V   -> VP ;             -- sleep
    UseV v = v ;

    -- : V2  -> NP -> VP ;       -- love it
    ComplV2 v2 np = {
      s = table {
            cl => v2.s ! cl ++ np.s } ;
      } ;

    -- : Comp  -> VP ;           -- be small
    UseComp comp = {
      s = table {
            cl => "be" ++ comp.s ! cl } ;
      } ;

    -- : AP  -> Comp ;           -- small
    CompAP ap = ap ;

    -- : VP -> Adv -> VP ;       -- sleep here
    AdvVP vp adv = {
      s = table {
            Class1 => vp.s ! Class1 ++ adv.s ;
            Class2 => vp.s ! Class2 ++ adv.s 
        } ;
      } ;

-- Noun
    -- : Det -> CN -> NP ;       -- the man
    DetCN det cn = {
      s = det.s ++ cn.s ;
      g = cn.g ;
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
      s = ap.s ! cn.g ++ cn.s ;
      g = cn.g ;
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

    he_Pron   = mkPron "he" Class2 ;
    she_Pron  = mkPron "she" Class1 ;
    they_Pron = mkPron "they" Class2 ;

oper

  mkPrep : Str -> {s : Str}  ;
  mkPrep str = {s = str} ;

  mkPron : Str -> NounClass -> {s : Str ; g : NounClass} ;
  mkPron str nc = {s = str ; g = nc} ;

-----------------------------------------------------
---------------- Lexicon part -----------------------
-----------------------------------------------------

oper
  mkN : Str -> NounClass -> {s : Str ; g : NounClass} ;
  mkN   str    nc         = {s = str ; g = nc} ;

  mkA : Str -> {s : NounClass => Str} ;
  mkA adj = {
    s = table {
          Class1 => adj + ".Adj.Class1" ;
          Class2 => adj + ".Adj.Class2" } ;
    } ;

  mkV : Str -> {s : NounClass => Str} ;
  mkV verb = {
    s = table {
          Class1 => verb + ".Verb.Class1" ;
          Class2 => verb + ".Verb.Class2" } ;
   } ;

  mkV2 : Str -> {s : NounClass => Str} ;
  mkV2 verb = {
    s = table {
          Class1 => verb + ".Verb2.Class1" ;
          Class2 => verb + ".Verb2.Class2" } ;
   } ;

  mkAdv : Str -> {s : Str} ;
  mkAdv str = {s = str} ;

lin
  already_Adv = mkAdv "already" ;
  animal_N = mkN "animal" Class1 ;
  apple_N = mkN "apple" Class2 ;
  baby_N = mkN "baby" Class1 ;
  bad_A = mkA "bad" ;
  beer_N = mkN "beer" Class2 ;
  big_A = mkA "big" ;
  bike_N = mkN "bike" Class1 ;
  bird_N = mkN "bird" Class2 ;
  black_A = mkA "black" ;
  blood_N = mkN "blood" Class1 ;
  blue_A = mkA "blue" ;
  boat_N = mkN "boat" Class2 ;
  book_N = mkN "book" Class1 ;
  boy_N = mkN "boy" Class2 ;
  bread_N = mkN "bread" Class1 ;
  break_V2 = mkV2 "break" ;
  buy_V2  = mkV2 "buy" ;
  car_N = mkN "car" Class2 ;
  cat_N = mkN "cat" Class1 ;
  child_N = mkN "child" Class2 ;
  city_N = mkN "city" Class1 ;
  clean_A = mkA "clean" ;
  clever_A = mkA "clever" ;
  cloud_N = mkN "cloud" Class2 ;
  cold_A = mkA "cold" ;
  come_V = mkV "come" ;
  computer_N = mkN "computer" Class1 ;
  cow_N = mkN "cow" Class2 ;
  dirty_A = mkA "dirty" ;
  dog_N = mkN "dog" Class1 ;
  drink_V2 = mkV2 "drink" ;
  eat_V2 = mkV2 "eat" ;
  find_V2 = mkV2 "find" ;
  fire_N = mkN "fire" Class2 ;
  fish_N = mkN "fish" Class1 ;
  flower_N = mkN "flower" Class2 ;
  friend_N = mkN "friend" Class1 ;
  girl_N = mkN "girl" Class2 ;
  good_A = mkA "good" ;
  go_V = mkV "go" ;
  grammar_N = mkN "grammar" Class1 ;
  green_A = mkA "green" ;
  heavy_A = mkA "heavy" ;
  horse_N = mkN "horse" Class2 ;
  hot_A = mkA "hot" ;
  house_N = mkN "house" Class1 ;
--  john_PN : PN ;
  jump_V = mkV "jump" ;
  kill_V2 = mkV2 "kill" ;
--  know_VS : VS ;
  language_N = mkN "language" Class2 ;
  live_V = mkV "live" ;
  love_V2  = mkV2 "love" ;
  man_N = mkN "man" Class1 ;
  milk_N = mkN "milk" Class2 ;
  music_N = mkN "music" Class1 ;
  new_A = mkA "new" ;
  now_Adv = mkAdv "now" ;
  old_A = mkA "old" ;
--  paris_PN : PN ;
  play_V = mkV "play" ;
  read_V2  = mkV2 "read" ;
  ready_A = mkA "ready" ;
  red_A = mkA "red" ;
  river_N = mkN "river" Class2 ;
  run_V = mkV "run" ;
  sea_N = mkN "sea" Class2 ;
  see_V2  = mkV2 "see" ;
  ship_N = mkN "ship" Class1 ;
  sleep_V = mkV "sleep" ;
  small_A = mkA "small" ;
  star_N = mkN "star" Class2 ;
  swim_V = mkV "swim" ;
  teach_V2 = mkV2 "teach" ;
  train_N = mkN "train" Class1 ;
  travel_V = mkV "travel" ;
  tree_N = mkN "tree" Class2 ;
  understand_V2 = mkV2 "understand" ;
  wait_V2 = mkV2 "wait" ;
  walk_V = mkV "walk" ;
  warm_A = mkA "warm" ;
  water_N = mkN "water" Class1 ;
  white_A = mkA "white" ;
  wine_N = mkN "wine" Class1 ;
  woman_N = mkN "woman" Class2 ;
  yellow_A = mkA "yellow" ;
  young_A = mkA "young" ;

}
