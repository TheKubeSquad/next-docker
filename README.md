# Next-Docker Example
This example demonstrates how to build a single Next.js application that uses environment variables at runtime, allowing for environment-specific values while using a single Docker image.

## Prerequisites
1. **Node.js 18.17 or later**
2. **Docker**
3. **A Kubernetes Cluster** (e.g., Docker-Desktop or Rancher-Desktop)
4. **Make CLI Tool**

## Steps to Complete the Example

### 1. Create a New Next.js Application

Run the following command and accept the default options:
```bash
npx create-next-app@latest
```

### 2. (Optional) Apply a shadcn theme for better visualizations.
Modify `app/globals.css` to include theme of choice from [ShadCN Themes](https://ui.shadcn.com/themes).
View my example at [`/app/globals.css`](./app/globals.css)

### 3. 3. Modify the Next.js Application to Use Environment Variables at Runtime
> Note: These variables must be used on Server Side Rendered components. Client Side Rendered components are NOT secure.

Open [`/app/page.tsx`](./app/page.tsx) and replace its content with the following code snippet:
```
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
```

This environment variable `ENVIRONMENT` is set through the Kubernetes manifest found at [`k8s-manifest.yaml`](k8s-manifest.yaml).
```
    env:
    - name: ENVIRONMENT
      value: "kubernetes-environment"
```

### 4. Configure Next.js for Building the Docker Image
Modify [`next.config.mjs`](next.config.mjs) and replace its content with the following:
```
/** @type {import('next').NextConfig} */
const nextConfig = {
  output: "standalone",
};

export default nextConfig;
```

### 5. Use the Recommended Dockerfile Configuration for Building Next.js Images
Create a `Dockerfile` in the root of the project. You can refer to the [Next.js with Docker example Dockerfile](https://github.com/vercel/next.js/blob/canary/examples/with-docker/Dockerfile) for guidance.


### 6. Build, Deploy, and Test our newly created Next.js application.
Use Makefile to build, deploy, and cleanup this example. Run commands from the root of this directory.

Run `make build` to build the new image.
>Optional: `make build` includes the optional variable declaration TAG, set it using `make build "TAG=1.0"`.
>The default value is "latest".

Deploy the Application
Ensure you are configured to use your Kubernetes cluster (you should be able to run `kubectl` commands). Then run: `make deploy`

This command will create a Kubernetes namespace, deployment, and run port-forwarding to port 3000. Open your browser and navigate to `localhost:3000` to view the application.

### 7. Clean Up the Next.js Application
Use the following command to destroy the Kubernetes resources:
`make cleanup`