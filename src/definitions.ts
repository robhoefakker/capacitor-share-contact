export interface ShareContactPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
