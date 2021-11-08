export interface SaveContactPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
