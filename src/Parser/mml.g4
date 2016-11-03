/*
 * The MIT License (MIT)
 *
 * Copyright (c) 2016 Tomona Nanase
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KKEY_IND,
 * EXPRESS OR IMPLIED, KEY_INCLUDKEY_ING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS KEY_FOR A PARTICULAR PURPOSE AND
 * NONKEY_INFRKEY_INGEMENT. KEY_IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE KEY_FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER KEY_IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISKEY_ING
 * FROM, OUT OF OR KEY_IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALKEY_INGS KEY_IN THE SOFTWARE.
 *
 */

grammar MML;

@lexer::header {
using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;
}

/*
 * parser rules
 */

program
 : ( NEWLINE | statement )* EOF
 ;

statement
 : expression NEWLINE
 ;

expression
 : tempo
 | volume
 | length
 | octave
 | voice
 ;

tempo
 : TEMPO INTEGER
 ;

volume
 : VOLUME INTEGER
 ;

length
 : LENGTH INTEGER
 ;

octave
 : OCTAVE INTEGER
 ;

voice
 : note (AND note)*
 ;

note
 : NOTE accidential? note_length? dots?
 | NOTE accidential? PERCENTAGE note_length
 | REST note_length? dots?
 | REST PERCENTAGE note_length
 ;

accidential
 : SHARP
 | PLUS
 | MINUS
 | DOUBLE_SHARP
 | DOUBLE_PLUS
 | DOUBLE_MINUS
 ;

note_length
 : INTEGER
 ;

dots
 : DOT+
 ;

/*
 * lexer rules
 */

NEWLINE
 : ( '\r'? '\n' | '\r' ) SPACES?
 ;

NOTE
 : [A-Ga-g]
 ;

SHARP:	'#';
PLUS:	'+';
MINUS:	'-';

DOUBLE_SHARP:	'##';
DOUBLE_PLUS:	'++';
DOUBLE_MINUS:	'--';

REST
 : [Rr]
 ;

INTEGER
 : DIGIT_NON_ZERO DIGIT*
 ;

DOT
 : '.'
 ;

AND
 : '&'
 ;

OCTAVE
 : [Oo]
 ;

OCTAVE_LEFT
 : '<'
 ;

OCTAVE_RIGHT
 : '>'
 ;

LENGTH
 : 'L'
 ;

VOLUME
 : 'V'
 ;

PRAGMA
 : '@'
 ;

PERCENTAGE
 : '%'
 ;

TEMPO
 : [Tt]
 ;

SKIP_
 : ( SPACES | COMMENT | LINE_JOINING ) -> skip
 ;

UNKNOWN_CHAR
 : .
 ;

/* 
 * fragments 
 */

fragment DIGIT
 : [0-9]
 ;

fragment DIGIT_NON_ZERO
 : [1-9]
 ;

fragment SPACES
 : [ \t]+
 ;

fragment COMMENT
 : '/*' .*? '*/'
 ;

fragment LINE_JOINING
 : '\\' SPACES? ( '\r'? '\n' | '\r' )
 ;
