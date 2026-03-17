# 🏗️ Terraform GitHub — Projekt Szkoleniowy

Przyjazny dla początkujących projekt Terraform do zarządzania zasobami GitHub na koncie osobistym.
Zaprojektowany jako praktyczne demo szkoleniowe — bezpieczny domyślnie, przejrzysty w kodzie.

---

## 📁 Struktura projektu

```
terraform-demo/
├── main.tf                              # Moduł główny – wywołuje moduły podrzędne
├── versions.tf                          # Wymagane wersje Terraform i providera
├── backend.tf                           # Konfiguracja lokalnego backendu stanu
├── providers.tf                         # Konfiguracja providera GitHub
├── variables.tf                         # Deklaracje zmiennych wejściowych
├── locals.tf                            # Wartości lokalne (np. prefiks nazw zasobów)
├── data.tf                              # Data sources – odczyt istniejących zasobów GitHub
├── outputs.tf                           # Wartości wyjściowe po wykonaniu apply
├── terraform.tfvars.example             # Przykładowe wartości zmiennych (skopiuj i uzupełnij)
├── .gitignore                           # Wyklucza sekrety i pliki stanu z Gita
└── modules/
    ├── repository/                  # ✅ W pełni zaimplementowany – tworzy repozytorium
    │   ├── main.tf
    │   ├── variables.tf
    │   ├── outputs.tf
    │   └── README.md
    ├── branch_protection/           # 🏋️ Szkielet do ćwiczeń
    │   ├── main.tf
    │   ├── variables.tf
    │   ├── outputs.tf
    │   └── README.md
    └── labels/                      # 🏋️ Szkielet do ćwiczeń
        ├── main.tf
        ├── variables.tf
        ├── outputs.tf
        └── README.md
```

---

## ✅ Wymagania wstępne

Przed rozpoczęciem upewnij się, że masz zainstalowane i skonfigurowane:

1. **Terraform** `>= 1.6.0`
   - Pobierz: https://developer.hashicorp.com/terraform/install
   - Sprawdź wersję: `terraform version`

2. **Git** (opcjonalnie, ale zalecany)
   - Pobierz: https://git-scm.com/downloads

3. **Konto GitHub** z Personal Access Token (PAT)
   - Wymagane uprawnienia: `repo` (pełny), `delete_repo`
   - Wygeneruj token: https://github.com/settings/tokens

---

## 🔐 Konfiguracja środowiska

### Opcja A — Zalecana: Zmienne środowiskowe (bez sekretów w plikach)

Ustaw dane uwierzytelniające jako zmienne środowiskowe. Terraform automatycznie odczytuje
zmienne z prefiksem `TF_VAR_`.

**Linux / macOS:**
```bash
export TF_VAR_github_token="ghp_twój_personal_access_token"
export TF_VAR_github_owner="twoja-nazwa-użytkownika-github"
```

**Windows PowerShell:**
```powershell
$env:TF_VAR_github_token="ghp_twój_personal_access_token"
$env:TF_VAR_github_owner="twoja-nazwa-użytkownika-github"
```

> 💡 Możesz dodać te linie do `~/.bashrc`, `~/.zshrc` lub profilu PowerShell, aby były trwałe między sesjami.

---

### Opcja B — Tylko na szkolenie/demo: plik `terraform.tfvars`

> ⚠️ **Nigdy nie commituj tego pliku do Gita.** Jest on uwzględniony w `.gitignore` właśnie z tego powodu.

```bash
# Skopiuj plik przykładowy
cp terraform.tfvars.example terraform.tfvars
```

Następnie otwórz `terraform.tfvars` i uzupełnij wartości:

```hcl
github_token = "ghp_twój_personal_access_token"
github_owner = "twoja-nazwa-użytkownika-github"
```

---

## 🚀 Uruchomienie

### Krok 1 — Inicjalizacja Terraform

Pobiera wtyczkę providera GitHub i konfiguruje lokalny backend.

```bash
terraform init
```

Oczekiwany wynik:
```
Terraform has been successfully initialized!
```

---

### Krok 2 — Formatowanie kodu (opcjonalne, ale zalecane)

Automatycznie formatuje wszystkie pliki `.tf` do kanonicznego stylu.

```bash
terraform fmt -recursive
```

---

### Krok 3 — Walidacja konfiguracji

Sprawdza błędy składniowe i logiczne bez łączenia się z GitHub.

```bash
terraform validate
```

Oczekiwany wynik:
```
Success! The configuration is valid.
```

---

### Krok 4 — Podgląd zmian

Pokazuje dokładnie co Terraform utworzy, zmieni lub usunie. **Żadne zmiany nie są jeszcze aplikowane.**

```bash
terraform plan
```

Przejrzyj uważnie wynik. Powinieneś zobaczyć `+ create` dla nowego repozytorium.

---

### Krok 5 — Aplikowanie zmian

Tworzy zasoby na Twoim koncie GitHub.

```bash
terraform apply
```

Wpisz `yes` gdy zostaniesz o to poproszony. Po zakończeniu zobaczysz wartości wyjściowe:

```
Outputs:

repository_name          = "training-demo-repo"
repository_url           = "https://github.com/twoja-nazwa/training-demo-repo"
repository_ssh_clone_url = "git@github.com:twoja-nazwa/training-demo-repo.git"
...
```

Otwórz URL w przeglądarce i zweryfikuj, że repozytorium zostało utworzone! 🎉

---

## 🛡️ Tryb bezpieczny — prefiks `training-`

Wszystkie zasoby tworzone przez ten projekt otrzymują automatycznie prefiks `training-`.
Dzięki temu są:
- Łatwo identyfikowalne na Twoim koncie GitHub
- Wyraźnie oddzielone od Twoich właściwych projektów
- Proste do usunięcia po zakończeniu szkolenia

Prefiks jest zdefiniowany w `locals.tf`:
```hcl
resource_prefix      = "training"
repository_full_name = "training-${var.repository_name}"
```

---

## 🧹 Sprzątanie — usuwanie zasobów

Po zakończeniu sesji szkoleniowej usuń wszystkie utworzone zasoby poleceniem:

```bash
terraform destroy
```

Wpisz `yes` gdy zostaniesz o to poproszony. Terraform usunie repozytorium `training-*` z GitHub.

> 💡 Możesz też najpierw zobaczyć co zostanie usunięte za pomocą `terraform plan -destroy`.

---

## 📋 Dostosowywanie demo

Możesz nadpisać domyślne wartości edytując `terraform.tfvars` lub przekazując flagi `-var`:

```bash
# Zmień nazwę repozytorium i ustaw je jako prywatne
terraform apply \
  -var="repository_name=moje-szkolenie" \
  -var="repository_visibility=private"
```

Wszystkie dostępne zmienne są opisane w pliku `variables.tf`.

---

## 🔍 Data Sources — odczytywanie istniejących zasobów

Terraform może nie tylko **tworzyć** zasoby, ale także **odczytywać** istniejące z API providera.
Służą do tego bloki `data`, zdefiniowane w pliku `data.tf`.

**Kluczowa zasada:** Bloki `data` nigdy niczego nie tworzą, nie modyfikują ani nie usuwają — są tylko do odczytu.

### Składnia

```hcl
# Odczyt zasobu istniejącego na GitHubie (nie tworzy niczego nowego)
data "github_user" "current" {
  username = ""   # pusty string = zalogowany użytkownik
}

# Odwołanie do odczytanej wartości w innym miejscu konfiguracji:
output "my_login" {
  value = data.github_user.current.login
}
```

### Data sources używane w tym projekcie

| Data source | Nazwa lokalna | Co odczytuje |
|-------------|---------------|--------------|
| `github_user` | `current` | Dane zalogowanego użytkownika (właściciela tokenu PAT) |
| `github_user` | `owner` | Publiczny profil użytkownika `var.github_owner` |
| `github_repository` | `demo` | Metadane utworzonego repozytorium demo |
| `github_branch` | `main` | SHA ostatniego commita na gałęzi `main` |

### Po wykonaniu `terraform apply` zobaczysz m.in. następujące outputy z data sources

```
current_user_login       = "twoja-nazwa-użytkownika"
current_user_name        = "Twoje Imię i Nazwisko"
owner_public_repos       = 42
demo_repo_default_branch = "main"
demo_repo_topics         = ["terraform", "terraform-training", "training", "demo"]
main_branch_sha          = "a1b2c3d4e5f6..."
```

### Kiedy używać `depends_on` z data sources?

Gdy data source odczytuje zasób, który **Terraform właśnie sam stworzył**, musisz poinformować
Terraform żeby poczekał używając `depends_on`. Bez tego data source może wykonać się zanim
zasób jeszcze istnieje i zwrócić błąd.

```hcl
data "github_repository" "demo" {
  full_name  = "${var.github_owner}/${local.repository_full_name}"
  depends_on = [module.demo_repository]   # ← poczekaj na stworzenie repo
}
```

---

## 🏋️ Kolejne ćwiczenia

Po pomyślnym uruchomieniu głównego demo spróbuj zaimplementować moduły-ćwiczenia:

### Ćwiczenie 1 — Branch Protection (ochrona gałęzi)

**Moduł:** `modules/branch_protection/`

**Cel:** Zabezpiecz gałąź `main` swojego repozytorium:
- Wymagaj co najmniej 1 zatwierdzenia (approving review) przed mergem
- Odrzucaj przestarzałe recenzje po nowym pushu
- Blokuj force push

**Kroki:**
1. Otwórz `modules/branch_protection/main.tf`
2. Zaimplementuj zasób `github_branch_protection` używając zmiennych z `variables.tf`
3. Odkomentuj blok `module "demo_branch_protection"` w głównym `main.tf`
4. Uruchom `terraform plan` i `terraform apply`

📖 Dokumentacja providera: https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_protection

---

### Ćwiczenie 2 — Issue Labels (etykiety zgłoszeń)

**Moduł:** `modules/labels/`

**Cel:** Utwórz zestaw własnych etykiet issues na repozytorium używając `for_each`.

**Kroki:**
1. Otwórz `modules/labels/main.tf`
2. Zaimplementuj `github_issue_label` z iteracją `for_each`
3. Odkomentuj blok `module "demo_labels"` w głównym `main.tf`
4. Uruchom `terraform plan` i `terraform apply`

📖 Dokumentacja providera: https://registry.terraform.io/providers/integrations/github/latest/docs/resources/issue_label

---

## 🛠️ Przydatne komendy i flagi Terraform

Poniżej znajdziesz zestawienie najczęściej używanych komend i flag, które spotkasz w codziennej pracy z Terraform.

---

### `terraform init` — inicjalizacja projektu

Pobiera providery, inicjalizuje backend i moduły. Uruchamiaj zawsze po:
- pierwszym pobraniu projektu
- zmianie wersji providera w `versions.tf`
- zmianie konfiguracji backendu w `backend.tf`
- dodaniu nowego modułu

```bash
# Podstawowe użycie
terraform init

# Wymuś ponowne pobranie providerów (np. po ręcznym usunięciu .terraform/)
terraform init -upgrade

# Zmień konfigurację backendu bez migracji stanu (przydatne przy zmianie workspace'u)
terraform init -reconfigure

# Zmień backend I automatycznie przenieś istniejący stan do nowego backendu
terraform init -migrate-state

# Nie instaluj providerów z internetu – używaj tylko lokalnego cache
terraform init -plugin-dir=~/.terraform.d/plugins
```

| Flaga | Kiedy używać |
|-------|-------------|
| `-upgrade` | Aktualizacja providera do nowszej wersji zgodnej z constraints |
| `-reconfigure` | Zmiana backendu bez przenoszenia stanu (np. reset do lokalnego) |
| `-migrate-state` | Przeniesienie stanu np. z lokalnego do S3/Azure/GCS |
| `-plugin-dir` | Środowiska bez dostępu do internetu (air-gapped) |

---

### `terraform plan` — podgląd zmian

Pokazuje co Terraform zamierza zrobić. Nie wykonuje żadnych zmian.

```bash
# Podstawowy plan
terraform plan

# Zapisz plan do pliku (przydatne w CI/CD – apply wykona DOKŁADNIE ten plan)
terraform plan -out=tfplan

# Pokaż szczegółowe różnice dla każdego atrybutu zasobu
terraform plan -detailed-exitcode

# Ogranicz liczbę równoległych operacji (domyślnie 10)
terraform plan -parallelism=5

# Podgląd usuwania zasobów (bez faktycznego usuwania)
terraform plan -destroy

# Nadpisz wartość zmiennej bez edycji pliku
terraform plan -var="repository_visibility=private"

# Użyj alternatywnego pliku zmiennych
terraform plan -var-file="prod.tfvars"

# Wyklucz konkretny zasób z planu (Terraform 1.5+)
terraform plan -exclude="module.demo_labels"
```

---

### `terraform apply` — aplikowanie zmian

Tworzy, modyfikuje lub usuwa zasoby zgodnie z konfiguracją.

```bash
# Interaktywne apply (pyta o potwierdzenie)
terraform apply

# Automatyczne potwierdzenie – używane w CI/CD
terraform apply -auto-approve

# Wykonaj DOKŁADNIE plan zapisany wcześniej przez plan -out
terraform apply tfplan

# Aplikuj tylko konkretny zasób (przydatne przy debugowaniu)
terraform apply -target="module.demo_repository"

# Aplikuj kilka konkretnych zasobów
terraform apply -target="module.demo_repository" -target="module.demo_labels"
```

> ⚠️ Używaj `-target` tylko w wyjątkowych sytuacjach. Regularne używanie może prowadzić
> do niespójności stanu Terraform z rzeczywistą infrastrukturą.

---

### `terraform destroy` — usuwanie zasobów

Usuwa wszystkie zasoby zarządzane przez Terraform w danym workspace.

```bash
# Interaktywne usuwanie (pyta o potwierdzenie)
terraform destroy

# Automatyczne potwierdzenie (używane w CI/CD lub skryptach cleanup)
terraform destroy -auto-approve

# Usuń tylko konkretny zasób
terraform destroy -target="module.demo_repository"
```

---

### `terraform state` — zarządzanie stanem

Stan Terraform (`terraform.tfstate`) to plik, który przechowuje mapowanie między
konfiguracją a rzeczywistymi zasobami w chmurze/API. Komendy `state` pozwalają
nim zarządzać ręcznie.

```bash
# Wyświetl listę wszystkich zasobów w stanie
terraform state list

# Pokaż szczegółowe informacje o konkretnym zasobie
terraform state show "module.demo_repository.github_repository.this"

# Usuń zasób ze stanu BEZ usuwania go z GitHuba
# Przydatne gdy chcesz "zapomnieć" o zasobie bez jego niszczenia
terraform state rm "module.demo_repository.github_repository.this"

# Przenieś zasób do innego adresu w stanie (np. po refaktoringu modułu)
terraform state mv \
  "module.demo_repository.github_repository.this" \
  "module.new_repository.github_repository.this"

# Pobierz zdalny stan i zapisz lokalnie (backup)
terraform state pull > backup.tfstate

# Nadpisz stan zdalny lokalnym plikiem (OSTROŻNIE!)
terraform state push backup.tfstate
```

| Komenda | Kiedy używać |
|---------|-------------|
| `state list` | Sprawdzenie co Terraform zarządza |
| `state show` | Debugowanie – sprawdzenie atrybutów zasobu w stanie |
| `state rm` | Usunięcie zasobu z kontroli Terraform (zasób pozostaje w API) |
| `state mv` | Refaktoring – zmiana nazwy modułu lub zasobu bez recreate |
| `state pull/push` | Backup stanu lub ręczna naprawa w awaryjnych sytuacjach |

---

### `terraform import` — importowanie istniejących zasobów

Pozwala "przejąć" zasób, który już istnieje w API (np. GitHub), pod zarządzanie Terraform
bez jego niszczenia i odtwarzania.

```bash
# Importuj istniejące repozytorium GitHub do stanu Terraform
terraform import "module.demo_repository.github_repository.this" "nazwa-repozytorium"

# Import z użyciem pliku konfiguracji import (Terraform 1.5+ – zalecane)
# Dodaj do main.tf:
# import {
#   to = module.demo_repository.github_repository.this
#   id = "nazwa-repozytorium"
# }
# A następnie:
terraform plan    # Terraform pokaże import jako część planu
terraform apply   # Wykona import
```

> 💡 **Terraform 1.5+** wprowadził blok `import {}` w plikach `.tf`, który jest
> bardziej przejrzysty i deklaratywny niż komenda CLI.

---

### `terraform output` — wyświetlanie wartości wyjściowych

```bash
# Pokaż wszystkie outputy
terraform output

# Pokaż konkretny output
terraform output repository_url

# Zwróć wartość w formacie JSON (przydatne w skryptach)
terraform output -json repository_url

# Zwróć surową wartość bez cudzysłowów (przydatne w skryptach bash)
terraform output -raw repository_url
```

---

### `terraform workspace` — zarządzanie workspace'ami

Workspace'y pozwalają przechowywać osobne pliki stanu dla różnych środowisk
(np. `dev`, `staging`, `prod`) przy tej samej konfiguracji.

```bash
# Wyświetl dostępne workspace'y (* = aktywny)
terraform workspace list

# Utwórz nowy workspace
terraform workspace new staging

# Przełącz się na istniejący workspace
terraform workspace select staging

# Pokaż aktywny workspace
terraform workspace show

# Usuń workspace (musi być pusty – brak zasobów w stanie)
terraform workspace delete staging
```

> ⚠️ Workspace'y są wygodne, ale w dużych projektach produkcyjnych zaleca się
> osobne katalogi (lub osobne repozytoria) dla każdego środowiska zamiast workspace'ów.

---

### `terraform fmt` i `terraform validate` — jakość kodu

```bash
# Sformatuj wszystkie pliki .tf w bieżącym katalogu
terraform fmt

# Sformatuj rekurencyjnie (włącznie z modułami)
terraform fmt -recursive

# Sprawdź formatowanie BEZ wprowadzania zmian (przydatne w CI)
terraform fmt -check -recursive

# Sprawdź poprawność konfiguracji (składnia + typy zmiennych)
terraform validate
```

---

### `terraform console` — interaktywna konsola

Pozwala testować wyrażenia Terraform (funkcje, zmienne, locals) bez uruchamiania `plan/apply`.

```bash
terraform console
```

Przykłady użycia wewnątrz konsoli:
```hcl
# Testuj funkcje wbudowane
> upper("hello")
"HELLO"

> join("-", ["training", "demo", "repo"])
"training-demo-repo"

> length(["a", "b", "c"])
3

# Sprawdź wartość lokalną
> local.repository_full_name
"training-demo-repo"

# Wyjście z konsoli
> exit
```

---

### `terraform graph` — wizualizacja zależności

Generuje graf zależności między zasobami w formacie Graphviz (DOT).

```bash
# Wygeneruj graf i zapisz do pliku
terraform graph > graph.dot

# Wizualizuj w przeglądarce (wymaga zainstalowanego Graphviz)
terraform graph | dot -Tsvg > graph.svg
```

---

### Zmienne środowiskowe Terraform

Terraform obsługuje kilka specjalnych zmiennych środowiskowych:

| Zmienna | Opis |
|---------|------|
| `TF_VAR_<nazwa>` | Przekazuje wartość do zmiennej Terraform (np. `TF_VAR_github_token`) |
| `TF_LOG` | Poziom logowania: `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR` |
| `TF_LOG_PATH` | Ścieżka do pliku z logami (np. `TF_LOG_PATH=./terraform.log`) |
| `TF_CLI_ARGS` | Domyślne flagi dla wszystkich komend (np. `TF_CLI_ARGS="-no-color"`) |
| `TF_CLI_ARGS_plan` | Domyślne flagi tylko dla `terraform plan` |
| `TF_CLI_ARGS_apply` | Domyślne flagi tylko dla `terraform apply` |
| `TF_DATA_DIR` | Alternatywna lokalizacja dla katalogu `.terraform/` |
| `TF_WORKSPACE` | Automatyczny wybór workspace'u |

```bash
# Przykład: włącz szczegółowe logowanie przy debugowaniu
export TF_LOG=DEBUG
export TF_LOG_PATH=./debug.log
terraform plan
```

---

## 📚 Przydatne linki

| Zasób | URL |
|-------|-----|
| Dokumentacja Terraform | https://developer.hashicorp.com/terraform/docs |
| Dokumentacja providera GitHub | https://registry.terraform.io/providers/integrations/github/latest/docs |
| Ustawienia PAT na GitHub | https://github.com/settings/tokens |
| Dokumentacja języka Terraform | https://developer.hashicorp.com/terraform/language |
