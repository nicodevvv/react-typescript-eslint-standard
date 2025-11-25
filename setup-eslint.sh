#!/bin/bash

# Script para configurar ESLint con reglas Standard en proyectos React + TypeScript
# Uso: ./setup-eslint.sh

echo "🔧 Configurando ESLint para React + TypeScript con reglas Standard..."

# Instalar dependencias de ESLint
echo "📦 Instalando dependencias de ESLint..."
npm install -D \
  @eslint/js \
  eslint \
  eslint-plugin-react-hooks \
  eslint-plugin-react-refresh \
  globals \
  typescript-eslint

# Crear archivo de configuración eslint.config.js
echo "📝 Creando archivo de configuración eslint.config.js..."
cat > eslint.config.js << 'EOF'
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
EOF

# Añadir script lint al package.json si no existe
echo "📋 Verificando scripts en package.json..."
if ! grep -q '"lint"' package.json; then
  echo "Añadiendo script lint a package.json..."
  # Este comando usa jq si está disponible, si no, avisa al usuario
  if command -v jq &> /dev/null; then
    jq '.scripts.lint = "eslint ."' package.json > package.json.tmp && mv package.json.tmp package.json
  else
    echo "⚠️  Por favor, añade manualmente este script a tu package.json:"
    echo '  "lint": "eslint ."'
  fi
fi

echo "✅ Configuración completada!"
echo ""
echo "Puedes ejecutar el linter con: npm run lint"
