FROM node:lts-alpine

# https://github.com/hexops/dockerfile/blob/main/Dockerfile#L14
#
# Non-root user for security purposes.
#
RUN addgroup --gid 10001 --system nonroot \
    && adduser  --uid 10000 --system --ingroup nonroot --home /home/nonroot nonroot

WORKDIR /home/nonroot/app

# Give the nonroot user all rights to the workdir
RUN chown -R nonroot ./

# Set the user to nonroot before proceeding
USER nonroot

# Set the global npm package directory
ENV NPM_CONFIG_PREFIX=/home/nonroot/.npm-global
# Set the global npm package directory binary folder to PATH
ENV PATH=$PATH:/home/nonroot/.npm-global/bin

# We use serve as we do not need anything specific for this applications as we
# put CloudFront as a layer above where we configure what we need of headers.
# If any configuration is needed, have a look at this page: https://github.com/vercel/serve-handler#options
RUN npm i -g serve

COPY index.html /home/nonroot/app

EXPOSE 3000

CMD [ "serve", "--no-clipboard", "/home/nonroot/app" ]
