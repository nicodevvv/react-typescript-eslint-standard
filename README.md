# ESLint Setup for React + TypeScript

This script automatically configures ESLint with Standard-style rules for React projects using TypeScript.

## Usage

### On Linux/macOS:

1. Copy the `setup-eslint.sh` file to the root of your new project.
2. Run:
   ```bash
   ./setup-eslint.sh
   ```

### On Windows:

**Option 1 - PowerShell (Recommended):**
1. Copy the `setup-eslint.ps1` file to the root of your new project.
2. Run:
   ```powershell
   .\setup-eslint.ps1
   ```

**Option 2 - Command Prompt:**
1. Copy the `setup-eslint.bat` file to the root of your new project.
2. Run:
   ```cmd
   setup-eslint.bat
   ```

### Included Features:

- ✅ ESLint 9 with flat config configuration
- ✅ Support for React + TypeScript
- ✅ Standard-style rules (no semicolons, single quotes, etc.)
- ✅ Explicit function typing (warnings)
- ✅ React Hooks and React Refresh

### Applied Rules:

- No semicolons (`;`)
- Single quotes (`'`)
- 2-space indentation
- No trailing commas
- Space before function parentheses
- Explicit function typing (warning)
- And more Standard-
- style formatting rules

### Run the linter:
npm run lint
