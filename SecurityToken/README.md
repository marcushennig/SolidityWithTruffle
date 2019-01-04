# Smart Contract Development

## Tack stack

Install the following tools

- [Visual Studio](https://code.visualstudio.com/download)
- [Truffle](https://truffleframework.com/truffle)
- [Ganache](https://truffleframework.com/ganache)

Furthermore get the following plugins for VS Code:

- [Solidity](https://marketplace.visualstudio.com/items?itemName=JuanBlanco.solidity)
- [Solidity Extended](https://marketplace.visualstudio.com/items?itemName=beaugunderson.solidity-extended)

## Build Project

Create project folder and create basic project structure with truffle:

```bash
truffle init
```

Visual Studio plugin [solidity](https://marketplace.visualstudio.com/items?itemName=JuanBlanco.solidity) can use local compiler. Hence, install solc locally in project folder by:

```bash
npm install solc
```

Start Visual Studio Code:

```bash
code .
```

Change truffle-config.js

```js
networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*",
    },
    ...
}
```

## Deployment

in the **migrations/** folder add a java script file with the following code

```js
const Fibonacci = artifacts.require("Fibonacci");

module.exports = function(deployer) {
    
    deployer.deploy(Fibonacci);
    
};
```

## [Debug Unit Tests](https://ethereum.stackexchange.com/questions/41094/debugging-js-unit-tests-with-truffle-framework-in-vs-code)

See that you have **truffle-core** locally in your project. If not, do:

```bash
npm install truffle-core
```

Then use a configuration similar to this: ( Debug -> Open Configurations )

```json
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "type": "node",
            "request": "launch",
            "name": "truffle test (debugable)",
            "cwd": "${workspaceFolder}",
            "program": "${workspaceFolder}\\node_modules/truffle-core/cli.js",
            "args": [
                "test"
            ]
        }
    ]
}
```

## [Debug Solidity Contracts](https://truffleframework.com/tutorials/debugger-variable-inspection)
