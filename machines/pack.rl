// vim: filetype=ragel

%%{

  machine pack;

  include "pack_actions.rl";

  ignored = (space | 0)*;

  count = digit >start_digit digit* @count;

  count_modifier    = '*' %rest | count?;
  platform_modifier = ([_!] %platform)? count_modifier;
  modifier          = count_modifier | [_!] @non_native_error;

  S = (('S' | 's') platform_modifier) %check_size %S;
  I = (('I' | 'i') platform_modifier) %check_size %I;
  L = (('L' | 'l') platform_modifier) %check_size %L;

  C = (('C' | 'c') modifier) %check_size %C;
  n = ('n'         modifier) %check_size %n;
  N = ('N'         modifier) %check_size %N;
  v = ('v'         modifier) %check_size %v;
  V = ('V'         modifier) %check_size %V;
  Q = (('Q' | 'q') modifier) %check_size %Q;

  D = (('D' | 'd') modifier) %check_size %D;
  E = (('E'      ) modifier) %check_size %E;
  e = (('e'      ) modifier) %check_size %e;
  F = (('F' | 'f') modifier) %check_size %F;
  G = (('G'      ) modifier) %check_size %G;
  g = (('g'      ) modifier) %check_size %g;

  X  = ('X' modifier) %X;
  x  = ('x' modifier) %x;
  at = ('@' modifier) %at;

  A = ('A' modifier) %string_check_size %A;
  a = ('a' modifier) %string_check_size %a;
  Z = ('Z' modifier) %string_check_size %Z;

  integers  = C | S | I | L | n | N | v | V | Q;
  floats    = D | E | e | F | G | g;
  strings   = A | a | Z;
  moves     = X | x | at;

  directives = integers | strings | moves | floats;

  main := (directives >start ignored)+ %done;

  write data;
  write init;
  write exec;

}%%
