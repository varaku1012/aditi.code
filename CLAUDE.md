# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is the AditiCode monorepo containing three main projects:
1. **aditicode.agents** - Main platform with microservices and applications
2. **aditi.terminal** - Electron-based desktop IDE with integrated terminal
3. **aditi.code.ui** - React UI components for context engineering

## Essential Commands

### Main Platform (aditicode.agents)
```bash
# Prerequisites: Node.js 18+, pnpm 8+
cd aditicode.agents
pnpm install          # Install all dependencies
pnpm setup           # Run initial setup
pnpm dev             # Start all services in development mode
pnpm build           # Build all packages
pnpm test            # Run all tests
pnpm lint            # Run ESLint on all packages
pnpm format          # Format with Prettier
pnpm clean           # Clean build artifacts

# Working on specific apps
cd apps/web && pnpm dev      # Web IDE
cd apps/cli && pnpm build    # CLI tool
cd apps/desktop && pnpm dev  # Desktop app
```

### Terminal App (aditi.terminal)
```bash
cd aditi.terminal
npm install
npm start           # Start Electron app
npm run dev         # Start with debug mode
npm run build       # Build the application
```

### Running Tests
```bash
# In aditicode.agents - runs all tests with 80% coverage requirement
pnpm test

# For a specific package
cd packages/[package-name] && npm test

# Watch mode for development
npm run test:watch
```

## High-Level Architecture

### Monorepo Structure (aditicode.agents)
- **apps/** - User-facing applications
  - `cli` - Command line interface
  - `desktop` - Electron desktop app
  - `web` - Next.js web IDE
  - `playground` - Vite-based playground
- **services/** - Microservices
  - `api-gateway` - Central API entry point
  - `context-service` - Manages Infinite Context Graph
  - `agent-runtime` - Executes AI agents
  - `marketplace` - Skill pack distribution
  - `telemetry` - Usage analytics
- **packages/** - Shared libraries
  - `context-fabric` - Core context engine
  - `agent-os` - Agent orchestration
  - `ui-components` - Shared React components
  - `sdk` - Developer SDK
  - `types` - TypeScript type definitions
- **infrastructure/** - Deployment configs
  - `kubernetes/` - K8s manifests
  - `terraform/` - Infrastructure as code

### Key Architectural Patterns

1. **Microservices Architecture** - Services communicate via gRPC
2. **Infinite Context Graph** - Core innovation for unlimited context storage
3. **Multi-Agent System** - Orchestrated by AgentOS with hot-swappable skill packs
4. **Event-Driven Design** - Real-time updates and agent coordination
5. **TypeScript Everywhere** - Strict typing across the entire stack

### Technology Stack
- **Frontend**: React, Next.js, Electron, Monaco Editor, XTerm.js
- **Backend**: Node.js, TypeScript, Rust (performance-critical components)
- **Data**: PostgreSQL, Redis, Qdrant (vector DB)
- **Build**: Turbo, pnpm workspaces, Vite, Next.js
- **Quality**: ESLint, Prettier, Jest, Husky

### Development Workflow

1. **Code Style**: Prettier with 100 char width, single quotes, semicolons
2. **Testing**: Jest with 80% coverage requirement
3. **Pre-commit**: Husky runs lint-staged (ESLint + Prettier)
4. **TypeScript**: Strict mode enabled, ES2022 target
5. **Monorepo**: Changes to shared packages trigger dependent rebuilds via Turbo

### Important Context

- The platform's core differentiator is the "Infinite Context Engine" that makes every file, ticket, and conversation queryable by AI agents
- Multi-agent architecture allows specialized agents to collaborate on complex tasks
- Enterprise-focused with SOC 2 and FedRAMP compliance considerations
- Marketplace ecosystem for community-contributed skill packs
- Currently in early development phase, focusing on Windows support first