# main.tf - kalkulator Terraform z obsługą dzielenia przez 0

variable "liczba1" {
  description = "Pierwsza liczba"
  type        = number
#  default     = 10
}

variable "liczba2" {
  description = "Druga liczba"
  type        = number
#  default     = 2
}

variable "operacja" {
  description = "Operacja: '+', '-', '*', '/'"
  type        = string
 # default     = "*"

  validation {
    condition     = contains(["+", "-", "*", "/"], var.operacja)
    error_message = "Operacja musi być jedną z: '+', '-', '*', '/'."
  }
}

locals {
  # Wszystkie operacje w oddzielnych locals (bezpieczne typy number)
  dodawanie         = var.liczba1 + var.liczba2
  odejmowanie       = var.liczba1 - var.liczba2
  mnozenie          = var.liczba1 * var.liczba2
  dzielenie_bezpieczne = var.liczba2 != 0 ? var.liczba1 / var.liczba2 : 999999
  
  # JEDNA LINIA - główny wynik
  wynik = var.operacja == "+" ? local.dodawanie : var.operacja == "-" ? local.odejmowanie : var.operacja == "*" ? local.mnozenie : local.dzielenie_bezpieczne
  
  # Status jako string (typ string)
  status = var.operacja == "/" && var.liczba2 == 0 ? "DZIELENIE PRZEZ 0!" : "OK"
}

output "wynik" {
  value = local.wynik
}

output "status_operacji" {
  value = local.status
}

output "szczegoly" {
  value = "L1=${var.liczba1} L2=${var.liczba2} OP=${var.operacja} W=${local.wynik}"
}
