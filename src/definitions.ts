export interface ShareContactPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
  share(
    name: string,
    phoneNumber: string,
    email: string,
    website: string,
    company: string,
    jobTitle: string,
  ): Promise<{ results: any[] }>;
}
