resource ResDummy = {

param
  Number = Sg | Pl ;

oper

-- Determiners
  Determiner : Type = {s : Str ; n : Number} ;

  mkDet : Str -> Number -> Determiner ;
  mkDet   str    num    =  {s = str ; n = num} ;

-- Nouns
  Noun : Type = {s : Number => Str} ;

   mkN = overload {
   	  mkN : Str -> Noun = regN ;
	  mkN : Str -> Str -> Noun = worstN ;
	} ;

  worstN : Str -> Str -> Noun ;
  worstN   sg     pl  = {
	s = table { Sg => sg ; 
				Pl => pl }
    } ;

  regN : Str -> Noun ;
  regN sg =
  	let pl : Str = case sg of {
  					  b + ("a"|"e"|"i"|"o"|"u") + "y"
  					  			=> sg + "s" ;
  		              bab + "y" => bab + "ies" ;
  		              _         => sg + "s" 
    			    } ;
     in worstN sg pl ;

-- Pronouns
  -- TODO: add case in an inflection table
  Pronoun : Type = {s : Str} ;

  mkPron : Str -> Pronoun ;
  mkPron str = {s = str} ;



-- Verbs
  --Verb : Type = {s : ??Agr => Str} ;
  Verb : Type = {s : Str} ;

  mkV : Str -> Verb ;
  mkV str = {s = str} ;

  mkV2 : Str -> Verb ;
  mkV2 str = {s = str} ;



  mkA : Str -> {s : Str} ;
  mkA str = {s = str} ;

  mkAdv : Str -> {s : Str} ;
  mkAdv str = {s = str} ;

  mkPrep : Str -> {s : Str}  ;
  mkPrep str = {s = str} ;

}