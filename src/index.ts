import { registerPlugin } from '@capacitor/core';

import type { ShareContactPlugin } from './definitions';

const ShareContact = registerPlugin<ShareContactPlugin>('ShareContact', {
  web: () => import('./web').then(m => new m.ShareContactWeb()),
});

export * from './definitions';
export { ShareContact };
