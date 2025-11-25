@echo off
REM Script para configurar ESLint con reglas Standard en proyectos React + TypeScript
REM Uso: setup-eslint.bat

echo 🔧 Configurando ESLint para React + TypeScript con reglas Standard...
echo.

REM Instalar dependencias de ESLint
echo 📦 Instalando dependencias de ESLint...
call npm install -D @eslint/js eslint eslint-plugin-react-hooks eslint-plugin-react-refresh globals typescript-eslint

REM Crear archivo de configuración eslint.config.js
echo 📝 Creando archivo de configuración eslint.config.js...
(
echo import js from "@eslint/js";
echo import globals from "globals";
echo import reactHooks from "eslint-plugin-react-hooks";
echo import reactRefresh from "eslint-plugin-react-refresh";
echo import tseslint from "typescript-eslint";
echo import { defineConfig, globalIgnores } from "eslint/config";
echo.
echo export default defineConfig^([
echo   globalIgnores^(["dist"]^),
echo   {
echo     files: ["**/*.{ts,tsx}"],
echo     extends: [
echo       js.configs.recommended,
echo       tseslint.configs.recommended,
echo       reactHooks.configs.flat.recommended,
echo       reactRefresh.configs.vite,
echo     ],
echo     languageOptions: {
echo        parser: tseslint.parser,
echo        ecmaVersion: 2020,
echo        sourceType: "module",
echo        globals: globals.browser,
echo        parserOptions: {
echo            ecmaFeatures: {
echo            jsx: true,
echo            },
echo        },
echo     },
echo     rules: {
echo       "@typescript-eslint/explicit-function-return-type": "warn",
echo       "@typescript-eslint/explicit-module-boundary-types": "warn",
echo       // Standard rules
echo       "semi": ["error", "never"],
echo       "quotes": ["error", "single", { "avoidEscape": true }],
echo       "indent": ["error", 2],
echo       "comma-dangle": ["error", "never"],
echo       "space-before-function-paren": ["error", "always"],
echo       "keyword-spacing": ["error", { "before": true, "after": true }],
echo       "space-infix-ops": "error",
echo       "eol-last": ["error", "always"],
echo       "no-multiple-empty-lines": ["error", { "max": 1, "maxEOF": 0 }],
echo       "object-curly-spacing": ["error", "always"],
echo       "array-bracket-spacing": ["error", "never"],
echo       "comma-spacing": ["error", { "before": false, "after": true }],
echo       "key-spacing": ["error", { "beforeColon": false, "afterColon": true }],
echo       "no-trailing-spaces": "error",
echo       "no-multi-spaces": "error",
echo       "arrow-spacing": ["error", { "before": true, "after": true }],
echo     },
echo   },
echo ]^);
) > eslint.config.js

REM Verificar si existe el script lint
echo 📋 Verificando scripts en package.json...
findstr /C:"\"lint\"" package.json >nul
if errorlevel 1 (
    echo ⚠️  Por favor, añade manualmente este script a tu package.json:
    echo   "lint": "eslint ."
) else (
    echo Script lint ya existe en package.json
)

echo.
echo ✅ Configuración completada!
echo.
echo Puedes ejecutar el linter con: npm run lint
pause
