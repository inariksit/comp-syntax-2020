--# -path=.:../abstract

concrete MicroLangDutch of MicroLang = {


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
    V,      -- one-place verb                      e.g. "sleep" 
    V2,     -- two-place verb                      e.g. "love"
    Adv     -- adverbial phrase                    e.g. "in the house"
     = {s : Str} ;

    NP      -- noun phrase (subject or object)     e.g. "the red house"
      = Pronoun ** {ct : NPContraction} ;

    Pron    -- personal pronoun                    e.g. "she"
      = Pronoun ;

    Prep   -- preposition, or just case           e.g. "in", dative
      = Preposition ;

    Det,    -- determiner phrase                   e.g. "those"
    A,      -- one-place adjective                 e.g. "warm"
    AP      -- adjectival phrase                   e.g. "warm"
      = Adj ;

    N,      -- common noun                         e.g. "house"
    CN      -- common noun (without determiner)    e.g. "red house"
      = Noun ;

  lin
-- Phrase
    -- : S  -> Utt ;         -- he walks
    UttS s = s ;

    -- : NP -> Utt ;         -- he
    UttNP np = {s = np.s ! Nom} ;

-- Sentence
    -- : NP -> VP -> S ;             -- John walks
    PredVPS np vp = {s = np.s ! Nom ++ vp.s} ;

-- Verb
    -- : V   -> VP ;             -- sleep
    UseV v = v ;

    -- : V2  -> NP -> VP ;       -- love it
    ComplV2 v2 np = {s = v2.s ++ np.s ! Acc} ;

    -- : Comp  -> VP ;           -- be small
    UseComp comp = {s = "is" ++ comp.s} ;

    -- : AP  -> Comp ;           -- small
    CompAP ap = {s = ap.s ! Het} ;

    -- : VP -> Adv -> VP ;       -- sleep here
    AdvVP vp adv = {s = vp.s ++ adv.s} ;

-- Noun
    ThisNP = {
      s = table {_ => "dit"} ;
      ct = Yes Dit ;
    } ;

    ThatNP = {
      s = table {_ => "dat"} ;
      ct = Yes Dat ;
    } ;

    SomethingNP = {
      s = table {_ => "iets"} ;
      ct = Yes Iets ;
    } ;

    -- : Det -> CN -> NP ;       -- the man
    DetCN det cn = {
      s = table {_ => det.s ! cn.g ++ cn.s} ;
      ct = No ;
    } ;

    -- : Pron -> NP ;            -- she
    UsePron pron = pron ** {ct = Yes Er} ;

    -- : Det ;                   -- indefinite singular
    -- a_Det = {s = table {_ => "een"}} ;

    -- : Det ;                   -- indefinite plural
    -- aPl_Det = {s = ""} ;

    -- : Det ;                   -- definite singular   ---s
    the_Det = {
      s = table {
            De => "de" ;
            Het => "het" }
      } ;

    -- : Det ;                   -- definite plural     ---s
    --thePl_Det = {s = "de"} ;

    -- : N -> CN ;               -- house
    UseN n = n ;

    -- : AP -> CN -> CN ;        -- big house
    AdjCN ap cn = cn ** {
      s = ap.s ! cn.g ++ cn.s ;
    } ;

-- Adjective
    -- : A  -> AP ;              -- warm
    PositA a = a ;

-- Adverb
    -- : Prep -> NP -> Adv ;     -- in the house
    PrepNP prep np = {s =
      case <prep.ct,np.ct> of {
        <Contr, Yes dem> => prep.contr_forms ! dem ;
        _ => prep.s ++ np.s ! Acc

      } ;
    } ;

-- Structural
    -- : Prep ;
    in_Prep = mkPrep "in" "in" Contr ;
    on_Prep = mkPrep "op" "op" Contr ;
    with_Prep = mkPrep "met" "mee" Contr ;
    without_Prep = mkPrep "zonder" "zonder" NoContr ;

    {- TODO: prepositions and pronouns combine
         "on him/her"   ≠ "op hem/haar"
         "in him/her"   ≠ "in hem/haar"
         "with him/her" ≠ "met hem/haar"
       = "erop" "erin" "ermee"

      More forms:
        this: "hierop" "hierin" "hiermee" …
        that: "daarop" "daarin" "daarmee" …
        what: "waarop" "waarin" "waarmee" …
        + some, none, all …

      Separate in negation (Wikipedia):
        Ik reken erop.       'I am counting on it.'
        Ik reken er niet op. 'I am not counting on it.'

     -}

    he_Pron   = mkPron "hij" "hem" ;
    she_Pron  = mkPron "zij" "haar" ;
{-     they_Pron = mkPron "zij" ; -- No plurals yet -}

-----------------------------------------------------
---------------- Lexicon part -----------------------
-----------------------------------------------------

lin
  apple_N = mkN "appel" De ;
  baby_N = mkN "baby" De ;
  beer_N = mkN "bier" De ;
  blood_N = mkN "bloed" Het ;
  blue_A = mkA "blauw" ;
  break_V2 = mkV2 "breekt" ; -- 3rd person sg form
  cat_N = mkN "kat" De ;
  cold_A = mkA "koud" ;
  come_V = mkV "komt" ; -- 3rd person sg form
  computer_N = mkN "computer" De ;
  swim_V = mkV "zwemt" ;
  warm_A = mkA "warm" ;
  water_N = mkN "water" Het ;
  white_A = mkA "wit" ;
  wine_N = mkN "wijn" De ;
{-
  already_Adv = mkAdv "al" ;
  animal_N = mkN "dier" Het ;
  bad_A = mkA "slecht" ;
  big_A = mkA "groot" ;
  bike_N = mkN "fiets" De ;
  bird_N = mkN "vogel" De ;
  black_A = mkA "zwart" ;
  boat_N = mkN "boot" De ;
  book_N = mkN "boek" De ;
  boy_N = mkN "jongen" De ;
  bread_N = mkN "brood" Het ;
  buy_V2  = mkV2 "kopen" ;
  car_N = mkN "auto" De ;
  child_N = mkN "kind" Het ;
  city_N = mkN "stad" De ;
  clean_A = mkA "school" ;
  clever_A = mkA "slim" ;
  cloud_N = mkN "wolk" De ;
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
  john_PN : PN ;
  jump_V = mkV "jump" ;
  kill_V2 = mkV2 "kill" ;
  know_VS : VS ;
  language_N = mkN "language" ;
  live_V = mkV "live" ;
  love_V2  = mkV2 "love" ;
  man_N = mkN "man" ;
  milk_N = mkN "milk" ;
  music_N = mkN "music" ;
  new_A = mkA "new" ;
  now_Adv = mkAdv "now" ;
  old_A = mkA "old" ;
  paris_PN : PN ;
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
  teach_V2 = mkV2 "teach" ;
  train_N = mkN "train" ;
  travel_V = mkV "travel" ;
  tree_N = mkN "tree" ;
  understand_V2 = mkV2 "understand" ;
  wait_V2 = mkV2 "wait" ;
  walk_V = mkV "walk" ;
  woman_N = mkN "woman" ;
  yellow_A = mkA "yellow" ;
  young_A = mkA "young" ; 
  -}

--------------------------
-- Resource + paradigms --
--------------------------

param
  Contraction = Contr | NoContr ;

  NPContraction = Yes Demonstrative | No ;

  Case = Nom | Acc ;
  Demonstrative = Er | Dit | Dat | Wat | Alles | Iets | Niets ;

oper

  Preposition : Type = {
    s : Str ;
    contr_forms : Demonstrative => Str ;
    ct : Contraction
    } ;

  mkPrep : Str -> Str -> Contraction -> Preposition ;
  mkPrep met mee ct = {
    s = met ;
    contr_forms = table {
        Er => "er" + mee ;
        Dit => "hier" + mee ;
        Dat => "daar" + mee ;
        Wat => "waar" + mee ;
        Alles => "overal" ++ mee ;
        Iets => "ergens" ++ mee ;
        Niets => "nergens" ++ mee
      } ;
    ct = ct
  } ;

  Pronoun : Type = {s : Case => Str} ;

  mkPron : Str -> Str -> Pronoun ;
  mkPron nom acc = {
    s = table {Nom => nom ; Acc => acc}
    } ;

param
  Gender = De | Het ;

oper
  v : pattern Str = #("a"|"e"|"i"|"o"|"u") ;
  c : pattern Str = #("p"|"t"|"k"|"m"|"n"|"s"|"d"|"l"|"r"|"w") ; -- incomplete

  Noun : Type = {s : Str ; g : Gender} ;
  Adj  : Type = {s : Gender => Str} ;

  mkN : Str -> Gender -> Noun  ;
  mkN sg gen = {s = sg ; g = gen} ;

  mkA : Str -> Adj ;
  mkA oud = 
    let oude : Str = case oud of {
          wi@(_ + #c + #v) + t@#c -- matches `_ + C + V + C`
            => wi + t + t + "e" ; -- Double last consonant
          _ => oud + "e" } in
    {s = table {
          Het => oud ;
          De  => oude }
    } ;

  mkV : Str -> {s : Str} ;
  mkV str = {s = str} ;

  mkV2 : Str -> {s : Str} ;
  mkV2 str = {s = str} ;

  mkAdv : Str -> {s : Str} ;
  mkAdv str = {s = str} ;


}
