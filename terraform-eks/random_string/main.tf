#---main.tf/random_string---

resource "random_string" "eks" {
  length = 5
 }