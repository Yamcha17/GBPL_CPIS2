#!/bin/bash

# Copyright 2017 Maxime Schmitt <max.schmitt@math.unistra.fr>
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#
# (1) Redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer.
#
# (2) Redistributions in binary form must reproduce the above copyright
# notice, this list of conditions and the following disclaimer in
# the documentation and/or other materials provided with the distribution.
#
# (3)The name of the author may not be used to
# endorse or promote products derived from this software without
# specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
# IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT,
# INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
# STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
# IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.

is_integer() {
  for i in "$@"
  do
    if [ -z "${i##*[!0-9]*}"  ]
    then
      return 1
    fi
  done
  return 0
}

if [ $# -ne 1  ]
then
  echo "Utilisation : $0 <entier1>"
  exit 1
fi

if ! is_integer $1
then
  echo "Veuillez entrer des entiers à la place de $1"
  exit 1
fi

somme=0
entier_initial=$1

while [ $entier_initial -ne 0 ]
do
  somme=$((somme + ($entier_initial % 10)))
  entier_initial=$(($entier_initial / 10))
done

echo "La somme des digits est $somme"

# Sur la chaîne de caractère

num_chars=${#1}

somme=0
while [ $num_chars -ge 0 ]
do
  char=${1:$num_chars:1}
  somme=$((somme + char))
  num_chars=$((num_chars - 1))
done

echo "La somme des digits est $somme"

# Avec des pipes
# On décompose la chaîne de caractères en ayant un caractère par ligne
# Puis chaque caractère est lu dans la fonction add_stream

add_stream() {
  somme=0
  while read character
  do
    somme=$((somme + character))
  done
  echo "La somme des digits est $somme"
}

echo $1 | sed 's/./&\n/g' | add_stream
