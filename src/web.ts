import { WebPlugin } from '@capacitor/core';

import type { ShareContactPlugin } from './definitions';

export class ShareContactWeb extends WebPlugin implements ShareContactPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
