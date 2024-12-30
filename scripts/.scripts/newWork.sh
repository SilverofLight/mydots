#!/bin/bash

Name=${1}

if [ -z "$Name" ]; then
  echo "please enter a name"
else
  touch $Name.lean
  echo "import Mathlib.Data.Real.Basic" >>$Name.lean
  echo "import Mathlib.Tactic.Ring" >>$Name.lean
  echo "import Mathlib.Algebra.Ring.Basic" >>$Name.lean
  echo "import Mathlib.Tactic.Linarith" >>$Name.lean
  nvim $Name.lean
fi
