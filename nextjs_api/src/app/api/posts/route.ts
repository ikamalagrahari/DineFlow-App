// nextjs_api/app/api/posts/route.js

import { NextResponse } from "next/server";

export async function GET(request) {
  // In a real app, you'd fetch this from a database.
  const posts = [
    {
      userId: 1,
      id: 1,
      title: "My First Post from Next.js API",
      body: "This is the body of the first post. It's coming from my local server!",
    },
    {
      userId: 1,
      id: 2,
      title: "Another Awesome Post",
      body: "Hello, Flutter! Your Next.js backend is up and running.",
    },
  ];

  return NextResponse.json(posts);
}
