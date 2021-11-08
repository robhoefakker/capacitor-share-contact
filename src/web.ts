import { WebPlugin } from '@capacitor/core';

import type { SaveContactPlugin } from './definitions';

export class SaveContactWeb extends WebPlugin implements SaveContactPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
