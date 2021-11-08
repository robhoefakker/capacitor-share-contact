import { registerPlugin } from '@capacitor/core';

import type { SaveContactPlugin } from './definitions';

const SaveContact = registerPlugin<SaveContactPlugin>('SaveContact', {
  web: () => import('./web').then(m => new m.SaveContactWeb()),
});

export * from './definitions';
export { SaveContact };
