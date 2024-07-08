import { unstable_noStore as noStore } from "next/cache";

export default function Home() {
  noStore();

  const environment = process.env.ENVIRONMENT;

  return (
    <main className="flex min-h-screen flex-col items-center justify-start p-24">
      <h1>Next.js Docker</h1>
      <ul className="text-center">
        <li>Environment: {environment}</li>
      </ul>
    </main>
  );
}
