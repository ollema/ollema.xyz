import { defineCollection, z } from "astro:content";

const blog = defineCollection({
  type: "content",
  // type-check frontmatter using a schema
  schema: z.object({
    title: z.string(),
    description: z.string(),
    // transform string to Date object
    pubDate: z.coerce.date(),
    updatedDate: z.coerce.date().optional(),
    heroImage: z.string().optional(),
  }),
});

export const collections = { blog };
