# Dummy grammar: a very minimal concrete syntax

These grammars are meant for beginner GF grammarians to get started easier. They are written in a series of video tutorials, found at https://www.youtube.com/playlist?list=PL4L18Hhub0qFgLgFmzE4h-FxqemBcvWSW.

## MicroLangDummy.gf

All lincats are `{s : Str}`, all grammar rules are string concatenation. Produces sentences like "bird be bad", "they break they".

## MicroLangDummyWithResModule.gf + ResDummy.gf

Added a resource module `ResDummy` and moved lexical constructors there. Added also number in nouns, compare the differences to the base dummy:

```
MicroLang: PredVPS (DetCN aPl_Det (AdjCN (PositA small_A) (UseN friend_N))) (UseV jump_V)
MicroLangDummy: small friend jump
MicroLangDummyWithResModule: small friends jump

MicroLang: PredVPS (DetCN aPl_Det (AdjCN (PositA big_A) (UseN woman_N))) (UseComp (CompAP (PositA cold_A)))
MicroLangDummy: big woman be cold
MicroLangDummyWithResModule: big women be cold
```

## MicroLangDummyWithGender.gf

An implementation of a hypothetical language that is like English but has noun class/gender. The feature appears in adjective modification and predication, as well as verb inflection. 

This grammar produces sentences as follows (*bike* is of class 1, *apple* is of class 2):

```
> l PredVPS (DetCN the_Det (UseN bike_N)) (UseComp (CompAP (PositA warm_A)))
the bike be.Verb.Class1 warm.Adj.Class1

> l PredVPS (DetCN the_Det (UseN apple_N)) (UseComp (CompAP (PositA warm_A)))
the apple be.Verb.Class2 warm.Adj.Class2

> l PredVPS (DetCN the_Det (AdjCN (PositA warm_A) (UseN bike_N))) (UseV go_V)
the warm.Adj.Class1 bike go.Verb.Class1

> l PredVPS (DetCN the_Det (AdjCN (PositA warm_A) (UseN apple_N))) (UseV go_V)
the warm.Adj.Class2 apple go.Verb.Class2
```

