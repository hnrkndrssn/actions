FROM mcr.microsoft.com/dotnet/core/runtime:3.1-alpine

# Alpine base image does not have ICU libraries available
# https://github.com/dotnet/corefx/blob/master/Documentation/architecture/globalization-invariant-mode.md
RUN apk add --no-cache icu-libs bash
ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT false
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

# The dotnetcore bootstrapper doesnt work in alpine shell (built for bash)
# This allows invoking octo if running interactive container
RUN mkdir /octo \
    && echo "dotnet /octo/octo.dll \"\$@\"" > /octo/alpine \
    && ln /octo/alpine /usr/bin/octo \
    && chmod +x /usr/bin/octo

RUN export OCTO_TOOLS_VERSION=$(wget -qO- https://g.octopushq.com/latesttools | egrep -m 1 '"latest"' | awk -F '"' '{ print $4 }') \
    && wget -qc https://download.octopusdeploy.com/octopus-tools/$OCTO_TOOLS_VERSION/OctopusTools.$OCTO_TOOLS_VERSION.portable.tar.gz \
    && tar -zxvf OctopusTools.$OCTO_TOOLS_VERSION.portable.tar.gz -C /octo \
	&& rm OctopusTools.$OCTO_TOOLS_VERSION.portable.tar.gz

LABEL maintainer="devops@octopus.com"
LABEL octopus.push.action.version="1.0"
LABEL octopus.tools.version=$OCTO_TOOLS_VERSION

ADD create-release.sh /create-release.sh
RUN chmod +x /create-release.sh

ENTRYPOINT ["/create-release.sh"]