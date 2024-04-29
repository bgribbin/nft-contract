import { buildModule } from '@nomicfoundation/hardhat-ignition/modules';

const LockModule = buildModule('LockModule', (m) => {
  const lock = m.contract('MyToken', [], {});

  return { lock };
});

export default LockModule;
