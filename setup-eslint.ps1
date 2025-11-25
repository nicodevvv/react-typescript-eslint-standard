# Script para configurar ESLint con reglas Standard en proyectos React + TypeScript
# Uso: .\setup-eslint.ps1

Write-Host "🔧 Configurando ESLint para React + TypeScript con reglas Standard..." -ForegroundColor Cyan
Write-Host ""

# Instalar dependencias de ESLint
Write-Host "📦 Instalando dependencias de ESLint..." -ForegroundColor Yellow
npm install -D @eslint/js eslint eslint-plugin-react-hooks eslint-plugin-react-refresh globals typescript-eslint

# Crear archivo de configuración eslint.config.js
Write-Host "📝 Creando archivo de configuración eslint.config.js..." -ForegroundColor Yellow

$eslintConfig = @'
import js from "@eslint/js";
import globals from "globals";
import reactHooks from "eslint-plugin-react-hooks";
import reactRefresh from "eslint-plugin-react-refresh";
import tseslint from "typescript-eslint";
import { defineConfig, globalIgnores } from "eslint/config";

export default defineConfig([
  globalIgnores(["dist"]),
  {
    files: ["**/*.{ts,tsx}"],
    extends: [
      js.configs.recommended,
      tseslint.configs.recommended,
      reactHooks.configs.flat.recommended,
      reactRefresh.configs.vite,
    ],
    languageOptions: {
      ecmaVersion: 2020,
      globals: globals.browser,
    },
    rules: {
      "@typescript-eslint/explicit-function-return-type": "warn",
      "@typescript-eslint/explicit-module-boundary-types": "warn",
      // Standard rules
      "semi": ["error", "never"],
      "quotes": ["error", "single", { "avoidEscape": true }],
      "indent": ["error", 2],
      "comma-dangle": ["error", "never"],
      "space-before-function-paren": ["error", "always"],
      "keyword-spacing": ["error", { "before": true, "after": true }],
      "space-infix-ops": "error",
      "eol-last": ["error", "always"],
      "no-multiple-empty-lines": ["error", { "max": 1, "maxEOF": 0 }],
      "object-curly-spacing": ["error", "always"],
      "array-bracket-spacing": ["error", "never"],
      "comma-spacing": ["error", { "before": false, "after": true }],
      "key-spacing": ["error", { "beforeColon": false, "afterColon": true }],
      "no-trailing-spaces": "error",
      "no-multi-spaces": "error",
      "arrow-spacing": ["error", { "before": true, "after": true }],
    },
  },
]);
'@

Set-Content -Path "eslint.config.js" -Value $eslintConfig

# Verificar si existe el script lint
Write-Host "📋 Verificando scripts en package.json..." -ForegroundColor Yellow
$packageJson = Get-Content "package.json" -Raw
if ($packageJson -notmatch '"lint"') {
    Write-Host "⚠️  Por favor, añade manualmente este script a tu package.json:" -ForegroundColor Yellow
    Write-Host '  "lint": "eslint ."' -ForegroundColor White
} else {
    Write-Host "Script lint ya existe en package.json" -ForegroundColor Green
}

Write-Host ""
Write-Host "✅ Configuración completada!" -ForegroundColor Green
Write-Host ""
Write-Host "Puedes ejecutar el linter con: npm run lint" -ForegroundColor Cyan
