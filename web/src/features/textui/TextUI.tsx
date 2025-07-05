import React from 'react';
import { useNuiEvent } from '../../hooks/useNuiEvent';
import { Box, createStyles, Group } from '@mantine/core';
import ReactMarkdown from 'react-markdown';
import ScaleFade from '../../transitions/ScaleFade';
import remarkGfm from 'remark-gfm';
import type { TextUiPosition, TextUiProps } from '../../typings';
import MarkdownComponents from '../../config/MarkdownComponents';
import LibIcon from '../../components/LibIcon';
<<<<<<< HEAD
import { before } from 'node:test';
=======
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9

const useStyles = createStyles((theme, params: { position?: TextUiPosition }) => ({
  wrapper: {
    height: '100%',
    width: '100%',
    position: 'absolute',
    display: 'flex',
<<<<<<< HEAD
    // alignItems: params.position === 'top-center' ? 'baseline' : params.position === 'bottom-center' ? 'end' : 'center',
    alignItems: 'end',
    // justifyContent:
    //   params.position === 'right-center' ? 'flex-end' : params.position === 'left-center' ? 'flex-start' : 'center',
    justifyContent: 'center',
=======
    alignItems: 
      params.position === 'top-center' ? 'baseline' :
      params.position === 'bottom-center' ? 'flex-end' : 'center',
    justifyContent: 
      params.position === 'right-center' ? 'flex-end' :
      params.position === 'left-center' ? 'flex-start' : 'center',
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
  },
  container: {
    fontSize: 16,
    padding: 12,
    margin: 8,
<<<<<<< HEAD
    color: theme.colors.dark[0],
    fontFamily: 'Roboto',
    boxShadow: theme.shadows.sm,
    backgroundColor: '#252934',
    borderRadius: '3px',
=======
    backgroundColor: theme.colors.dark[6],
    color: theme.colors.dark[0],
    fontFamily: 'Roboto',
    borderRadius: theme.radius.sm,
    boxShadow: theme.shadows.sm,
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
  },
}));

const TextUI: React.FC = () => {
  const [data, setData] = React.useState<TextUiProps>({
    text: '',
<<<<<<< HEAD
    position: 'bottom-center',
    keybind: 'E',
=======
    position: 'right-center',
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
  });
  const [visible, setVisible] = React.useState(false);
  const { classes } = useStyles({ position: data.position });

  useNuiEvent<TextUiProps>('textUi', (data) => {
<<<<<<< HEAD
    // if (!data.position) data.position = 'right-center'; // Default right position
=======
    if (!data.position) data.position = 'right-center'; // Default right position
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
    setData(data);
    setVisible(true);
  });

  useNuiEvent('textUiHide', () => setVisible(false));

  return (
    <>
      <Box className={classes.wrapper}>
        <ScaleFade visible={visible}>
<<<<<<< HEAD
          <Box className="textui">
            <div className="textui-keybind-container">
              <div className="textui-keybind">
                <p>{data.keybind}</p>
              </div>
            </div>
            <Box style={data.style} className="textui-container">
              {/* {data.icon && (
                  <LibIcon
                    icon={data.icon}
                    fixedWidth
                    size="lg"
                    animation={data.iconAnimation}
                    style={{
                      color: data.iconColor,
                      alignSelf: !data.alignIcon || data.alignIcon === 'center' ? 'center' : 'start',
                    }}
                  />
                )} */}
              {/* <ReactMarkdown components={MarkdownComponents} remarkPlugins={[remarkGfm]}>
                {data.text}
              </ReactMarkdown> */}
              <p>{data.text}</p>
            </Box>
=======
          <Box style={data.style} className={classes.container}>
            <Group spacing={12}>
              {data.icon && (
                <LibIcon
                  icon={data.icon}
                  fixedWidth
                  size="lg"
                  animation={data.iconAnimation}
                  style={{
                    color: data.iconColor,
                    alignSelf: !data.alignIcon || data.alignIcon === 'center' ? 'center' : 'start',
                  }}
                />
              )}
              <ReactMarkdown components={MarkdownComponents} remarkPlugins={[remarkGfm]}>
                {data.text}
              </ReactMarkdown>
            </Group>
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
          </Box>
        </ScaleFade>
      </Box>
    </>
  );
};

export default TextUI;
