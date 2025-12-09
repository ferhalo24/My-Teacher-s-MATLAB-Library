function [line,file]=currentline(n)
s=dbstack;
line=s(n).line;
file=s(n).file;