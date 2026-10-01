# syntax=docker/dockerfile:1

FROM alpine:3.21

# Install ca-certificates for TLS connections
RUN apk add --no-cache ca-certificates

# Copy the binary from goreleaser (multi-arch build context)
ARG TARGETARCH
COPY linux/${TARGETARCH}/mcp-trino /usr/local/bin/mcp-trino

# Run as non-root user
RUN adduser -D -u 1000 mcp
USER mcp

# Streamable HTTP transport (set MCP_HTTP_ADDR, e.g. ":8080"); stdio when unset
EXPOSE 8080

ENTRYPOINT ["/usr/local/bin/mcp-trino"]
